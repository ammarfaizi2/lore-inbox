Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271867AbTGRPld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271858AbTGRPjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:39:42 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:145 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S271851AbTGRPiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:38:54 -0400
Date: Fri, 18 Jul 2003 17:53:45 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: More 2.6.0-test1-ac2 issues / RTC?
Message-ID: <20030718155345.GB27176@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this:
Jul 18 17:40:06 hummus2 ntpd[925]: ntpd exiting on signal 15
Jul 18 17:40:06 hummus2 modprobe: FATAL: Module /dev/rtc not found.
Jul 18 17:40:06 hummus2 modprobe: FATAL: Module /dev/misc/rtc not found.

But the kernel has RTC support:

# grep -i RTC .config
CONFIG_APM_RTC_IS_GMT=y
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_SND_RTCTIMER=m

Is /dev/rtc not /dev/rtc when using devfs?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
