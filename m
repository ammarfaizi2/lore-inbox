Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752655AbWAHRvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbWAHRvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbWAHRvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:51:21 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:56210 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1752655AbWAHRvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:51:20 -0500
Date: Sun, 8 Jan 2006 18:50:46 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub6.ifh.de
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH] Kconfig option to enable faulty Artec DVB-T USB devices,
 cleanups, documentation
In-Reply-To: <20051224132559.GB5789@stiffy.osknowledge.org>
Message-ID: <Pine.LNX.4.64.0601081838460.14698@pub6.ifh.de>
References: <20051224132559.GB5789@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I finally found the time to commit some of your cleanups to the 
V4L-DVB-CVS.

I only took some of your cleanups. The useful ones :)

Thanks for your help,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/

On Sat, 24 Dec 2005, Marc Koschewski wrote:
> The following patch adds a Kconfig option in the DVB-T USB section that enables
> a user to select wether some faulty Artec devices may be supported due to an
> invalid EEPROM. Some googling stated that some people had problems getting the
> device to be detected by the driver (though the device was stated to be
> supported by the module on various sites). As not anyone is into changing source
> code a Kconfig option would be appropriate for these users. Patrick Boettcher
> also suggested a Kconfig would make sense. Moreover, one may share the option in
> his/her .config accross several kernels instead of uncommenting the #define on
> any -git checkout or new kernel release. It was simply annoying. :)
>
> Moreover, there's some cleanup on indentation and such, added some explanation
> to the faulty UDB IDs code, re-ordered the list of supported devices in Kconfig
> to match out alphabet ;)
>
> The #ifdef-fing of dibusb-mc functions was removed due to Adrian Bunks' hint.
>
> Patrick Boettcher and the Linux DVB Maintainers are CC'ed...
>
> The patch is against the current -git but should cause no problems on the recent
> releases.
>
> Regards,
> 	marc
>
