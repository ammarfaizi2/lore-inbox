Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUANTnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUANTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:42:15 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:61575 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264534AbUANTl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:41:59 -0500
Date: Wed, 14 Jan 2004 20:41:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mariusz Zielinski <levi@wp-sa.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040114194151.GA1379@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040114142445.GA28377@ucw.cz> <20040114182202.GA32081@ucw.cz> <200401142029.33824.levi@wp-sa.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401142029.33824.levi@wp-sa.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 08:29:29PM +0100, Mariusz Zielinski wrote:

> Small adjustment:
> 
> diff -Nru a/drivers/char/input.h b/drivers/char/input.h
> --- a/drivers/char/input.h     2004-01-14 20:23:03.000000000 +0100
> +++ b/drivers/char/input.h2    2004-01-14 20:22:37.000000000 +0100
> @@ -194,7 +194,7 @@
>  #define KEY_102ND              86
>  #define KEY_F11                        87
>  #define KEY_F12                        88
> -#define KEY_ROMANJI            89
> +#define KEY_ROMAJI             89
>  #define KEY_KATAKANA           90
>  #define KEY_HIRAGANA           91
>  #define KEY_HENKAN             92

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
