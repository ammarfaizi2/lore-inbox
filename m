Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRDMWVq>; Fri, 13 Apr 2001 18:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRDMWVg>; Fri, 13 Apr 2001 18:21:36 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:28421 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132121AbRDMWVZ>;
	Fri, 13 Apr 2001 18:21:25 -0400
Message-ID: <20010414002120.A15596@win.tue.nl>
Date: Sat, 14 Apr 2001 00:21:20 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
In-Reply-To: <20010413150219.A440@napalm.go.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010413150219.A440@napalm.go.cz>; from Jan Dvorak on Fri, Apr 13, 2001 at 03:02:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 03:02:19PM +0200, Jan Dvorak wrote:

> i recently met with a new (Unisys) keyboard, which have (among 'normal'
> windows keys) 3 more keys on top of arrows, labeled by pictures as
> halfsun, halfmoon, and power switch. Following patch adds 'support' for them

> +#define E0_MSPOWER	128
> +#define E0_MSHALFMOON	129
> +#define E0_MSHALFSUN	130

No, these codes cannot be larger than 127 today.
You can use the utility setkeycodes to assign keycodes to these keys.

[One of the things for 2.5 is 15- or 31-bit keycodes.
The 7-bits we have today do no longer suffice. I have a 132-key keyboard.]

Andries
