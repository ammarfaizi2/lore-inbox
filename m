Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWBQQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWBQQiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBQQiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:38:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751139AbWBQQiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:38:03 -0500
Date: Fri, 17 Feb 2006 17:38:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060217163802.GI4422@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:56:51PM +0100, Jan Engelhardt wrote:
> >> >Make INPUT a bool.
> >> >
> >> >INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
> >> >make that much sense to make it modular.
> >> >
> >> modular would make sense to me - http://lkml.org/lkml/2006/1/25/106
> >>...
> >
> >I don't get your point:
> >You don't need INPUT modular for hotplugging devices.
> 
> Well that is, if one happens to plug in a, say, USB keyboard.


Let me repeat the same sentence more boldly:

YOU DO NOT NEED MODULES FOR HOTPLUGGING DEVICES.

Please try to understand this sentence.


And I've already given numbers why CONFIG_EMBEDDED=y and 
CONFIG_MODULES=y at the same time is insane.


> Jan Engelhardt


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

