Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVINTLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVINTLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbVINTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:11:44 -0400
Received: from er-systems.de ([217.172.180.163]:9991 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S932578AbVINTLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:11:43 -0400
Date: Wed, 14 Sep 2005 21:11:46 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
Subject: Re: forced to CONFIG_PM=y
In-Reply-To: <20050914185922.GA7516@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0509142106360.23029@er-systems.de>
References: <Pine.LNX.4.61.0509142002130.22437@er-systems.de>
 <20050914185922.GA7516@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-1371644837-1126725106=:23029"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1395022924-1371644837-1126725106=:23029
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 14 Sep 2005, Sam Ravnborg wrote:

> On Wed, Sep 14, 2005 at 08:16:10PM +0200, Thomas Voegtle wrote:
> > 
> > Hello,
> > 
> > on one computer, which I wanted to switch from 2.6.13 to 2.6.14-rc1 I was
> > forced to use CONFIG_PM, look:
> > 
> > thomas@tv2:~/linux-2.6.14-rc1> zgrep CONFIG_PM /proc/config.gz 
> > # CONFIG_PM is not set
> > thomas@tv2:~/linux-2.6.14-rc1> zcat /proc/config.gz > .config 
> > thomas@tv2:~/linux-2.6.14-rc1> make oldconfig
> > ...
> > *
> > * Power management options (ACPI, APM)
> > *
> > Power Management support (PM) [Y/?] y
> >   Power Management Debug Support (PM_DEBUG) [N/y/?] (NEW) 
> > 
> > 
> > I never had question if I want to have CONFIG_PM, the "y" was already 
> > there.
> Something else selected CONFIG_PM for you.
> Try to see help in menuconfig, here you can see what symbol selected
> CONFIG_PM.

I forgot to say I can switch it off again in the menuconfig, because I 
answer the following questions during oldconfig about APM and ACPI Support 
with "n".  Ok, the subject should be "I was forced to use menuconfig" 


      Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-1371644837-1126725106=:23029--
