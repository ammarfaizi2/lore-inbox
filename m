Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290233AbSAXCeB>; Wed, 23 Jan 2002 21:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290234AbSAXCdw>; Wed, 23 Jan 2002 21:33:52 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:51600 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290233AbSAXCdp>; Wed, 23 Jan 2002 21:33:45 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 03:33:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124023349Z290233-13996+11061@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23. January 2002 21:16, Hans-Peter Jansen wrote:
[-]
> BTW: Would some enlighted kernel brain explain, why 
>     [ ]     RTC stores time in GMT
> is only available, when APM is enabled. Does this mean, I cannot
> define my RTC mode when using ACPI?

Hans-Peter,
as you have ACPI running already, you should have noticed that "your" clock 
(RTC) is in GMT time without a separate switch.

Mine is (compare with send time):

/home/nuetzel> cat /proc/driver/rtc
rtc_time        : 02:33:14
rtc_date        : 2002-01-24
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
