Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWAVSFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAVSFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWAVSFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:05:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751298AbWAVSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:05:20 -0500
Subject: Re: [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Patrick Boettcher <patrick.boettcher@desy.de>,
       Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, johannes Stezenbach <js@linuxtv.org>
In-Reply-To: <Pine.LNX.4.64.0601221844170.1381@pub2.ifh.de>
References: <20060122171022.GA10003@stusta.de> <43D3C38C.3060100@gmail.com>
	 <Pine.LNX.4.64.0601221844170.1381@pub2.ifh.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 22 Jan 2006 16:05:03 -0200
Message-Id: <1137953103.6381.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

	I'll commit on our -git.

Cheers,
Mauro

Em Dom, 2006-01-22 às 18:51 +0100, Patrick Boettcher escreveu:
> Hi,
> 
> On Sun, 22 Jan 2006, Michael Krufky wrote:
> > Patrick, please let us know where you stand on this.   Can we apply this now?
> 
> It is just about this:
> 
> >> drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
> >> drivers/media/dvb/dvb-usb/dvb-usb.h          |    1
> 
> >> -int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx, int 
> >> *pos)
> >> +static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline 
> >> *hx,
> >> +			       int *pos)
> 
> >> -extern int dvb_usb_get_hexline(const struct firmware *, struct hexline *, 
> >> int *);
> 
> But I don't care much... Just another change I have to re-commit 
> afterwards. Just apply it.
> 
> regards,
> Patrick.
> 
> --
>    Mail: patrick.boettcher@desy.de
>    WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
Cheers, 
Mauro.

