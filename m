Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbREQUCK>; Thu, 17 May 2001 16:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbREQUBv>; Thu, 17 May 2001 16:01:51 -0400
Received: from viper.haque.net ([66.88.179.82]:31649 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S261861AbREQUBs>;
	Thu, 17 May 2001 16:01:48 -0400
Date: Thu, 17 May 2001 16:01:41 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Rich Baum <richbaum@acm.org>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.5pre3 warning fixes
In-Reply-To: <7C4D2505D3F@coral.indstate.edu>
Message-ID: <Pine.LNX.4.33.0105171557370.20195-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Rich Baum wrote:

> This patch fixes warnings in 2.4.5pre3 about extra tokens at the end of
> #endif statements and labels at the end of compound statements when using gcc
> 3.0 snapshots.
>
> -	if (c->devices != NULL)
> +	if (c->devices != NULL){
>  		c->devices->prev=d;
> +	}
>  	c->devices=d;
>

It didn't really complain about this one did it? Braces are optional
here or is that not part of ANSI C?

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

