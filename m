Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVEGEWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVEGEWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 00:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVEGEWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 00:22:36 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:62858 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262691AbVEGEWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 00:22:34 -0400
Date: Sat, 7 May 2005 00:18:38 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can NFS map different clients to different uid/gid?
In-Reply-To: <4ae3c1405043023127a2584bf@mail.gmail.com>
Message-ID: <Pine.GSO.4.33.0505070015370.1894-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Xin Zhao wrote:
>Subject: Can NFS map different clients to different uid/gid?
...

see also: rpc.ugidd

Unfortunately, it looks like ugidd went away years ago.  It was also a
security concern, but then again, no more so than nfsd trusting the uid
in the request.

knfsd does not support this.  Your best bet looks like gss/krb5, but I've
never used it. (I prefer to avoid NFS entirely, wherever possible)

--Ricky


