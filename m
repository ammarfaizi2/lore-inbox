Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTLJDXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLJDXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:23:05 -0500
Received: from arg0.net ([64.246.50.101]:13952 "HELO arg0.net")
	by vger.kernel.org with SMTP id S263439AbTLJDXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:23:02 -0500
Subject: Re: partially encrypted filesystem
From: Valient Gough <vgough@pobox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071026578.10527.37.camel@argo.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Dec 2003 19:22:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is slightly off topic, as it isn't a kernel implementation.  But in
regards to encryption options above the filesystem, there are user-space
tools for doing this.

For example (ahem, shamelessly plugging my own work)
pobox.com/~vgough/encfs.html - an encrypted filesystem in user-space
which uses the Linux kernel module FUSE (sf.net/projects/avf) to export
a filesystem interface to userland.  As a side note, FUSE also has
python, perl, and Java bindings for your programming pleasure.  

EncFS acts as a pass-thru layer to an existing filesystem, so it does
not require allocating space ahead of time.  But it does not do what the
original email asked, of encrypting on a file by file basis.  It is more
like a reimplementation of CFS, but without NFS being involved.  What
was asked for sounds more like TCFS (for 2.0.x and 2.2.x kernels).

regards,
Valient
vgough@pobox.com


