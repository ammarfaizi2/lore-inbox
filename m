Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUE2Uxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUE2Uxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE2Uxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:53:38 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:751 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264401AbUE2Uxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:53:35 -0400
Date: Sat, 29 May 2004 16:48:22 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Vincent van de Camp <vncnt@vzavenue.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
In-Reply-To: <40B8E81F.8050405@vzavenue.net>
Message-ID: <Pine.GSO.4.33.0405291645590.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Vincent van de Camp wrote:
>Thanks for the information. The debug option certainly was not intentional.
>I have tried fsck.xfs, but that didn't do anything but print a version
>message. I haven't tried xfs_repair. I didn't know of it's existance.
>That's definately something to try out next time, though.

fsck.xfs is a nop.  It intentionally doesn't do anything... if you've
reached a point where the filesystem *needs* to be checked and repaired,
you don't want any part of it to be automated.

And most distro's these days will needlessly run fsck everytime it's
been shutdown "improperly" (where "improperly" is defined as a file
didn't get deleted.)

--Ricky


