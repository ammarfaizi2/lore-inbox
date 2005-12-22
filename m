Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVLVGn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVLVGn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLVGn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:43:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57614 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965067AbVLVGn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:43:56 -0500
Date: Thu, 22 Dec 2005 07:43:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
Message-ID: <20051222064354.GN3917@stusta.de>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135228831.4122.15.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:20:31PM -0700, Dax Kelson wrote:

> I just got a shiny new (for me at least, the card has been out for
> months) Areca RAID card.
> 
> The driver (arcmsr) is in the -mm kernel, but hasn't yet made it to the
> mainline kernel. I'm curious what remains to be done before this can
> happen?


The top of the patch in -mm says:


(hch sez:

 There's lots of architectural problems.  It's doing it's own queueing, it's
 stuffing kernel structures into memory on the hardware and so on.  Basically
 someone knowledgeable about the hardware needs to start from scratch on it.

 Unfortunately it seems the hardware is more and more widely available so
 we'll have to bite that bullet one day.)


> Dax Kelson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

