Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRJOAIv>; Sun, 14 Oct 2001 20:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277944AbRJOAIn>; Sun, 14 Oct 2001 20:08:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277942AbRJOAIa>; Sun, 14 Oct 2001 20:08:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Wireless Extension update
Date: 14 Oct 2001 17:08:51 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qd9ej$982$1@cesium.transmeta.com>
In-Reply-To: <20011008191247.B6816@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011008191247.B6816@bougret.hpl.hp.com>
By author:    Jean Tourrilhes <jt@bougret.hpl.hp.com>
In newsgroup: linux.dev.kernel
>  /* -------------------------- IOCTL LIST -------------------------- */
> @@ -137,6 +144,8 @@
>  #define SIOCGIWRANGE	0x8B0B		/* Get range of parameters */
>  #define SIOCSIWPRIV	0x8B0C		/* Unused */
>  #define SIOCGIWPRIV	0x8B0D		/* get private ioctl interface info */
> +#define SIOCSIWSTATS	0x8B0E		/* Unused */
> +#define SIOCGIWSTATS	0x8B0F		/* Get /proc/net/wireless stats */
>  
>  /* Mobile IP support */
>  #define SIOCSIWSPY	0x8B10		/* set spy addresses */
> @@ -177,11 +186,33 @@
>  #define SIOCSIWPOWER	0x8B2C		/* set Power Management settings */
>  #define SIOCGIWPOWER	0x8B2D		/* get Power Management settings */
>  

Please, pretty please, use _IOC() macros...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
