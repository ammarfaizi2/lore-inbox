Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWIVCXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWIVCXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWIVCXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:23:55 -0400
Received: from sandeen.net ([209.173.210.139]:48744 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S932212AbWIVCXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:23:54 -0400
Message-ID: <4513493F.8090005@sandeen.net>
Date: Thu, 21 Sep 2006 21:23:59 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Timothy Shimmin <tes@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs mailing list <xfs@oss.sgi.com>
Subject: Re: [PATCH -mm] rescue large xfs preferred iosize from the inode
 diet patch
References: <45131334.6050803@sandeen.net> <45134472.7080002@sgi.com>
In-Reply-To: <45134472.7080002@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Shimmin wrote:

> Looked at your patch and then at our xfs code in the tree and
> the existing code is different than what yours is based on.
> I then noticed in the logs Nathan has actually made changes for this:
> 
> ----------------------------
> revision 1.254
> date: 2006/07/17 10:46:05;  author: nathans;  state: Exp;  lines: +20 -5
> modid: xfs-linux-melb:xfs-kern:26565a
> Update XFS for i_blksize removal from generic inode structure
> ----------------------------
> I even reviewed the change (and I don't remember it - getting old).
> 
> I looked at the mods scheduled for 2.6.19 and this is one of them.
> 
> So the fix for this is coming soon (and the fix is different from the
> one above).


Ah, ok, thanks guys.  Should have checked CVS I guess.

-Eric
