Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUJLECS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUJLECS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJLECS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:02:18 -0400
Received: from holomorphy.com ([207.189.100.168]:33156 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269425AbUJLECQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:02:16 -0400
Date: Mon, 11 Oct 2004 21:02:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andre Tomt <andre@tomt.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
Message-ID: <20041012040202.GV9106@holomorphy.com>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <416A53D3.9020002@tomt.net> <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org> <1097507381.2029.40.camel@mulgrave> <416ACF5E.80407@tomt.net> <1097522974.2029.161.camel@mulgrave> <Pine.LNX.4.58.0410111633410.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410111633410.3897@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, James Bottomley wrote:
>> Yes, well, that's one of the things that worries me slightly ... no-one
>> has reported the data corruption that the patch claims to fix.  That's
>> one of the reasons I was planning to take it through the normal cycle.

On Mon, Oct 11, 2004 at 04:35:50PM -0700, Linus Torvalds wrote:
> Well, as far as I can tell from the patch, the only way to get data 
> corruption from the bug is when you use the SCSI ioctl's at the same time 
> as the disk is busy.
> In other words, I think you'd have to do some special disk management, or
> possibly try to burn a CD on a SCSI CD-ROM (or other special device that
> uses the SCSI ioctl's) on the same controller. And nobody uses SCSI
> CD-burners any more, I'd think.

Hey! I do. For some reason I've not hit this data corruption. I guess
it's a good question as to why; maybe I trail mainline by long enough
on my "desktop" to have missed where it was introduced.


-- wli
