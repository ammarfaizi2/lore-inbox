Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTKNLiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKNLiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:38:55 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:18444 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262353AbTKNLix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:38:53 -0500
Date: Fri, 14 Nov 2003 12:38:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Patrick Beard" <patrick@scotcomms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Message-ID: <20031114113851.GA18054@win.tue.nl>
References: <bp27qb$tj2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bp27qb$tj2$1@sea.gmane.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:39:23AM -0000, Patrick Beard wrote:

> I'm having trouble with my smartmedia.
> 
> FAT: Bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev sda
> 
> These are Olympus sm cards, my camera is a Olympus 300-zoom.
> These cards camera and reader all worked well using Kernel 2.4.18.
> 
> My fstab entry is;
> /dev/sda    /mnt/smedia    vfat    rw,user,noauto    0,0

I would guess that you have to mount /dev/sda1 or perhaps /dev/sda4.
Isn't that what you do under 2.4?

Andries

