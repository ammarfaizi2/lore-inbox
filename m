Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIJKHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIJKHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIJKHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:07:55 -0400
Received: from main.gmane.org ([80.91.229.2]:21968 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750734AbVIJKHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:07:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24.
Date: Sat, 10 Sep 2005 12:05:00 +0200
Message-ID: <58obd5djrqk$.1nrux2jfwk0jg.dlg@40tude.net>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-147-119.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: linux-ntfs-dev@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005 10:18:01 +0100 (BST), Anton Altaparmakov wrote:

> Hi Linus, please pull from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD
> 
> This is the next NTFS update containing a ton of bug fixes several of 
> which fix bugs people actually hit in the big bad world...
> 
> Please apply.  Thanks!
> 
> I am sending the changesets as actual patches generated using git 
> format-patch for non-git users in follow up emails (in reply to this one).
> 
> Best regards,
> 
> 	Anton

BTW Anton, while looking for the best permission masks to be used when
mounting my NTFS paritions, I spotted what I think is a bug, or at
least an inconsistency between the way all fs drivers I use handle
umasks & friends, and the way NTFS does it. Basically, all the other
fs drivers take an octal representation of the masks. NTFS, instead,
seems to use _decimal_

(Of course, the spontaneous question is how comes that there isn't a
common fs code to read the common options?)

-- 
Giuseppe "Oblomov" Bilotta

Hic manebimus optime

