Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSHGLxJ>; Wed, 7 Aug 2002 07:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSHGLxJ>; Wed, 7 Aug 2002 07:53:09 -0400
Received: from ns.suse.de ([213.95.15.193]:15876 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316957AbSHGLxI>;
	Wed, 7 Aug 2002 07:53:08 -0400
Date: Wed, 7 Aug 2002 13:56:43 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020807135643.A9340@wotan.suse.de>
References: <20020807131813.A25485@wotan.suse.de> <200208071151.g77Bpmt19650@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208071151.g77Bpmt19650@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In a perfect would I'd be able to have config_experimental let me pick all
> the stuff not tested on x86_64. To do that sanely we have to fix the
> configuration language otherwise it will just never be maintainable and
> we will spend the rest of 2.4 haunted by "Why has xyz vanished on Alpha 
> in 2.4.21"

I severly doubt this will a problem. If you look at the drivers that
I marked this way on x86-64 I will bet some beer that they never worked
(some not even compiled) on alpha. Worrying about a userbase of drivers
who have never worked does not seem to be very useful. It definitely would
not be a regression at least.

Can you please shortly explain what will not be maintainable with my
proposal? 

-Andi
