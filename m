Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWAOAV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWAOAV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWAOAV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:21:57 -0500
Received: from mail29.messagelabs.com ([140.174.2.227]:1948 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1750923AbWAOAV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:21:56 -0500
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-25.tower-29.messagelabs.com!1137284505!23924003!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: jsm serial driver broken with flip buffer changes
Date: Sat, 14 Jan 2006 18:20:02 -0600
Message-ID: <335DD0B75189FB428E5C32680089FB9F442F62@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: jsm serial driver broken with flip buffer changes
Thread-Index: AcYZWKIgL58OZoXrQBalsb1xCY2ItQAEMtec
References: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee> <20060114221947.GT29663@stusta.de>
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Meelis Roos" <mroos@linux.ee>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Wendy Xiong" <wendyx@us.ltcfwd.linux.ibm.com>, <avenkat@us.ibm.com>
X-OriginalArrivalTime: 15 Jan 2006 00:21:45.0295 (UTC) FILETIME=[AAB5F5F0:01C61969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This will be remedied very shortly.
 
Ananda Venkataraman @ IBM is working to make the changes for the
new tty layer for the jsm driver as we speak.
 
Scott Kilau
Digi International
 

________________________________

From: Adrian Bunk [mailto:bunk@stusta.de]
Sent: Sat 1/14/2006 4:19 PM
To: Meelis Roos
Cc: Linux Kernel list; Kilau, Scott; Wendy Xiong
Subject: Re: jsm serial driver broken with flip buffer changes



On Sun, Jan 15, 2006 at 12:02:59AM +0200, Meelis Roos wrote:
> In current 1.6.15+git jsm serial driver is broken:
>
>   CC [M]  drivers/serial/jsm/jsm_tty.o
> drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
> drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named
> `flip'
>...

Don't say "no" at
  Code maturity level options
    Prompt for development and/or incomplete code/drivers
      Select only drivers expected to compile cleanly

> Meelis Roos (mroos@linux.ee)

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



