Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbUKVR3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUKVR3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUKVR2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:28:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262248AbUKVRYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:24:31 -0500
Date: Mon, 22 Nov 2004 12:24:21 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Jeffrey Mahoney <jeffm@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
In-Reply-To: <1101138640.18273.13.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0411221224100.6585-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Stephen Smalley wrote:

> Actually, I think we need a new flag field in the inode_security_struct
> to explicitly mark these "private" inodes for SELinux, so that
> inode_has_perm() can skip permission checking on them while still
> applying checks to any other inodes that may have the kernel SID (e.g.
> /proc/pid inodes for kernel threads).

Agreed.


- James
-- 
James Morris
<jmorris@redhat.com>


