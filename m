Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVKVDmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKVDmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVKVDmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:42:12 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:54897 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750926AbVKVDmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:42:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [git pull 03/14] Wistron - disable for x86_64
Date: Mon, 21 Nov 2005 22:42:06 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051120063611.269343000.dtor_core@ameritech.net> <20051120064419.680523000.dtor_core@ameritech.net> <Pine.LNX.4.62.0511201051360.2941@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0511201051360.2941@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212242.07012.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 04:52, Geert Uytterhoeven wrote:
> On Sun, 20 Nov 2005, Dmitry Torokhov wrote:
> >  
> >  config INPUT_WISTRON_BTNS
> >  	tristate "x86 Wistron laptop button interface"
> > -	depends on X86
> > +	depends on X86 && !X86_64
>                    ^^^^^^^^^^^^^^
> That should be just `X86_32' these days.
>

Oh, I wasn't aware of the new symbol. I will have that changed with the
next batch.

Thanks!

-- 
Dmitry
