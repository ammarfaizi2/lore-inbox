Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSE3Bg2>; Wed, 29 May 2002 21:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSE3Bg1>; Wed, 29 May 2002 21:36:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30992 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316070AbSE3BgZ>; Wed, 29 May 2002 21:36:25 -0400
Date: Wed, 29 May 2002 21:38:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa1
In-Reply-To: <20020530010125.GA1383@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205292137310.9955-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 May 2002, Andrea Arcangeli wrote:

> Only in 2.4.19pre8aa3: 00_get_pid-no-deadlock-and-boosted-3
> Only in 2.4.19pre9aa1: 10_get_pid-no-deadlock-and-boosted-4
>
> 	Discard the inferior attempt in pre9 and rediff (as Ihno noticed in
> 	practice the complexity dominates, if you fill the pid space the fix in
> 	mainline is useless anyways). Wonder why this much better fix isn't
> 	been merged instead (it is been submitted for both 2.2 and 2.4).
> 	This also fix a longstanding fork race present even in 2.2 that can
> 	lead to two tasks getting the same pid.

Could you be more verbose in explaining the problems with the current
approach and the advantages of your patch ?

Thanks

