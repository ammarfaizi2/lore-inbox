Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319776AbSIMUK6>; Fri, 13 Sep 2002 16:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319777AbSIMUK6>; Fri, 13 Sep 2002 16:10:58 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:26753 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319776AbSIMUK5>; Fri, 13 Sep 2002 16:10:57 -0400
Date: Fri, 13 Sep 2002 14:11:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ahmed Masud <masud@googgun.com>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Andreas Steinmetz <ast@domdv.de>, Bob_Tracy <rct@gherkin.frus.com>,
       <dag@brattli.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <3D82247A.80601@googgun.com>
Message-ID: <Pine.LNX.4.44.0209131411010.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Ahmed Masud wrote:
> #define DERROR(dbg, fmt, args...)                                          \
>     do { if (DEBUG_##dbg) {                                                \
>                 printk(KERN_INFO "irnet: %s() : ", __FUNCTION__);          \
>                 printk(fmt, ## args);                                      \
>          }                                                                 \
>     } while (0)

That's 100% senseless. It gains you nothing, it  takes you nothing...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

