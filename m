Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNGPr>; Wed, 14 Feb 2001 01:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBNGPi>; Wed, 14 Feb 2001 01:15:38 -0500
Received: from www.wen-online.de ([212.223.88.39]:31493 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129027AbRBNGPb>;
	Wed, 14 Feb 2001 01:15:31 -0500
Date: Wed, 14 Feb 2001 07:15:24 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: "C. D. Thompson-Walsh" <cdthompsonwalsh@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: Floppy drive[?] hang
In-Reply-To: <01021201172500.00922@ariel>
Message-ID: <Pine.Linu.4.10.10102140711550.1209-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, C. D. Thompson-Walsh wrote:

> [This sortof follows the format of the report form in REPORTING-BUGS]
> 1. I've found a consistent set of circumstances which will hang 2.4.x kernels 
> on my system.
> 
> 2. If the system is put under load to the point where it swaps heavily 
> (swapping appears to be pre-requisite, based on a little messing about), and 
> then given commands to use the floppy drive (mount, ls -- anything which 
> necessitates reading/writing to the floppy), it will hang with no message (it 
> does not OOPS, or at least it can not to the root console) I've done this 
> several times, with different disks and kernels, with and without X.

Hi,

I tried to reproduce this on my PIII-500 VIA chipset box and couldn't.
(problem doesn't seem to be generic fwiw)

	-Mike

