Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVHKSMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVHKSMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHKSME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:12:04 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:32718
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S932226AbVHKSMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:12:03 -0400
Date: Thu, 11 Aug 2005 19:11:54 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems on x86_64 (fwd)
In-Reply-To: <20050811152948.GH31019@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.58.0508111905310.8504@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0508110331360.3920@ppg_penguin.kenmoffat.uklinux.net>
 <20050811152948.GH31019@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Lennart Sorensen wrote:

>
> The kernel won't reread the partition table as long as ANY part of that
> disk is mounted.  Reboot (which of course unmounts everything) to reread
> the partition table.
>

 OK, I've noted that now, thanks for the clue.

>
> Just any reboot should have worked.  Once you reboot it reads the
> updated partition table and THEN you can mkfs the new partitions.  Until
> /proc/partitions matches what you see in fdisk, you really don't want to
> try access the partitions since it won't match on the next boot anyhow.
>
> Len Sorensen
>

 It certainly _seemed_ that the kernel was telling me one thing and
fdisk -l another, even after a reboot.  But because I hadn't appreciated
the importance of rebooting before accessing the new partitions, I
probably threw in some extra 'mkfs' commands to spice up the mix.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

