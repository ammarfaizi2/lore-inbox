Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUDGOEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUDGOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:04:24 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:40880 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263663AbUDGOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:03:57 -0400
Date: Wed, 7 Apr 2004 16:03:47 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_4KSTACKS in mm2?
Message-ID: <20040407140346.GC32088@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040407135551.GA32088@charite.de> <Pine.LNX.4.58.0404071000340.16677@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404071000340.16677@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@linuxpower.ca>:

> > Is there a way of disabling CONFIG_4KSTACKS in 2.6.5-mm2?
> > Or to make it configurable?
> 
> "arch/i386/Kconfig" line 1498 of 1542 --97%-- col 8
> config 4KSTACKS
>         def_bool y
> 
> you could just change that to 'n'

That's what I did (and it works) -- but it's not really intuitive or
even configurable (in the way of menuconfig or something).

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
