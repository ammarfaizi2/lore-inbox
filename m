Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTH3KId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTH3KId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:08:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44246 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263499AbTH3KIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:08:30 -0400
Date: Sat, 30 Aug 2003 12:08:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: module char_10_135
Message-ID: <20030830100823.GM7038@fs.tum.de>
References: <Pine.LNX.4.53.0308201736040.178@bigred.russwhit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308201736040.178@bigred.russwhit.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 05:54:15PM -0700, Russell Whitaker wrote:
> 
> During boot-up, and just after the setting the clock line, noticed the
> following line:
> 
> modeprobe: FATAL: module char_10_135 not found
> 
> First noticed this a few revisions ago. The contents of directory
> /lib/modules/2.6.0-test3-bk8/kernel/drivers/char:
> 
> agp/  genrtc.ko  hw_random.ko  lp.ko  rtc.ko
> 
> hmm, long shot, but perhaps this bug is related to not auto-loading
> module lp?

Minor 135 is rtc.

Do you have module-init-tools installed?

>   Russ

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

