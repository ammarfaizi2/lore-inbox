Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWBNSWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWBNSWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWBNSWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:22:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6407 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422757AbWBNSWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:22:40 -0500
Date: Tue, 14 Feb 2006 19:22:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060214182238.GB3513@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:14:21PM +0100, Jan Engelhardt wrote:
> >
> >Make INPUT a bool.
> >
> >INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
> >make that much sense to make it modular.
> >
> modular would make sense to me - http://lkml.org/lkml/2006/1/25/106
>...

I don't get your point:

You don't need INPUT modular for hotplugging devices.

In the normal EMBEDDED=n cases, users already do not have the choice of 
making INPUT modular.

If someone is working in an environment that is that space limited that 
he sets EMBEDDED=y, why on earth should he enable module support that 
uses relatively much space in his kernel?

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

