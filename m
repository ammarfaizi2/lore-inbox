Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269412AbUJLBKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbUJLBKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJLBKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:10:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62108 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266888AbUJLBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:07:43 -0400
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andre Tomt <andre@tomt.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410111633410.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
	 <416A53D3.9020002@tomt.ne t>
	 <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
	 <1097507381.2029.40.camel@mulgrave>  <416ACF5E.80407@tomt.net>
	 <1097522974.2029.161.camel@mulgrave>
	 <Pine.LNX.4.58.0410111633410.3897@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1097542884.1453.120.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 21:01:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 19:35, Linus Torvalds wrote:
> Well, as far as I can tell from the patch, the only way to get data 
> corruption from the bug is when you use the SCSI ioctl's at the same time 
> as the disk is busy.
> 
> In other words, I think you'd have to do some special disk management, or
> possibly try to burn a CD on a SCSI CD-ROM (or other special device that
> uses the SCSI ioctl's) on the same controller. And nobody uses SCSI
> CD-burners any more, I'd think.

This is not some far-out scenario.  For a long time Plextor SCSI burners
were the best on the market, there are 1000's of them out there.

Lee

