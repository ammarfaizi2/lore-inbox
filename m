Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbSJGP2G>; Mon, 7 Oct 2002 11:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263098AbSJGP2G>; Mon, 7 Oct 2002 11:28:06 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:24749 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263096AbSJGP2D>; Mon, 7 Oct 2002 11:28:03 -0400
Date: Mon, 7 Oct 2002 10:31:01 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <tsbogend@alpha.franken.de>,
       <felipewd@elipse.com.br>
Subject: Re: [PATCH] pcnet32 cable status check
In-Reply-To: <3D99D923.5080200@pobox.com>
Message-ID: <Pine.LNX.4.44.0210071027030.1408-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thus Spake Jeff Garzik:
>As Felipe mentioned, using the link interrupt instead of a timer is 
>preferred -- but my own preference would be to apply your patch with the 
>small remove-lp->mii-check fixup, and then investigate the support of 
>link interrupts.  The reasoning is that, pcnet32 covers a ton of chips, 
>and not all may support a link interrupt.

  Jeff, I came across a PCNET FAST/79C971, which apparently also does not
give an interrupt when the cable is pulled.  (My original tested card was a
PCnet/FAST III 79C975).

Kent

