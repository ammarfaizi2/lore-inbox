Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270689AbTG0HYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 03:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270691AbTG0HYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 03:24:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6408 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S270689AbTG0HYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 03:24:31 -0400
Date: Sun, 27 Jul 2003 09:39:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@arcor.de>,
       ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030727073920.GG643@alpha.home.local>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org> <200307271238.37918.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307271238.37918.kernel@kolivas.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

On Sun, Jul 27, 2003 at 12:38:37PM +1000, Con Kolivas wrote:
 
> No, this is what I have been trying to figure out; why is it that if we put 
> all the settings the same as 2.4 that it doesn't perform as nicely. 2.5/6 
> with the old settings is certainly better than with the vanilla settings, but 
> not as good as 2.4 O(1). It does not appear to be scheduler alone, but the 
> architectural changes to 2.5 that have changed interactivity are here to 
> stay, and improving the interactivity estimator in the scheduler does help it 
> anyway. 

just a thought : have you tried to set the timer to 100Hz instead of 1kHz to
compare with 2.4 ? It might make a difference too.

Cheers,
Willy

