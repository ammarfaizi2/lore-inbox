Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVBUR6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVBUR6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVBUR6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:58:47 -0500
Received: from mail1.kontent.de ([81.88.34.36]:37785 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262057AbVBUR6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:58:37 -0500
From: Oliver Neukum <oliver@neukum.org>
To: gene.heskett@verizon.net
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
Date: Mon, 21 Feb 2005 18:58:34 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200502211216.35194.gene.heskett@verizon.net>
In-Reply-To: <200502211216.35194.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502211858.34301.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Februar 2005 18:16 schrieb Gene Heskett:
> Greetings;
> 
> Motherboard is a biostar with nforce2 chipset, 2800xp cpu, gig of ram.
> 
> I've recently made the observation that while I can view 30fps video 
> from my firewire equipt movie camera with a minimal cpu hit of 2-3%, 
> but viewing the video from a webcam on a usb 1.1 circuit takes 30-40% 
> of the cpu, at half the frame rate.
> 
> Do I have something fubar in the usb?  Or is this just the nature of 
> the beast?

A video stream over usb1.1 must be compressed due to bandwidth available.
Decompression needs cpu.

	Regards
		Oliver
