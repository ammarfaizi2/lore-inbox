Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272137AbTHDS0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272135AbTHDS0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:26:00 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6660 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272128AbTHDSYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:24:17 -0400
Subject: Re: [PATCH] O13int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200308050207.18096.kernel@kolivas.org>
References: <200308050207.18096.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060021454.558.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 04 Aug 2003 20:24:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-04 at 18:07, Con Kolivas wrote:
> Changes:
> 
> Reverted the child penalty to 95 as new changes help this from hurting
> 
> Changed the logic behind loss of interactive credits to those that burn off 
> all their sleep_avg
> 
> Now all tasks get proportionately more sleep as their relative bonus drops 
> off. This has the effect of detecting a change from a cpu burner to an 
> interactive task more rapidly as in O10. 

Oh, yeah! This is damn good! I've had only a little bit time to try it,
but I think it rocks. Good work :-)

