Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292346AbSBPKKn>; Sat, 16 Feb 2002 05:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292347AbSBPKKe>; Sat, 16 Feb 2002 05:10:34 -0500
Received: from dsl-213-023-039-219.arcor-ip.net ([213.23.39.219]:45965 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292346AbSBPKKY>;
	Sat, 16 Feb 2002 05:10:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] get_request starvation fix
Date: Sat, 16 Feb 2002 11:13:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C69A196.B7325DC2@zip.com.au> <Pine.LNX.4.21.0202151515020.23069-100000@freak.distro.conectiva> <3C6E0B09.30983B1A@zip.com.au>
In-Reply-To: <3C6E0B09.30983B1A@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16c1qk-0002qM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 16, 2002 08:32 am, Andrew Morton wrote:
> However, contrary to my earlier guess, the request batching does
> make a measurable difference.  Changing the code so that we wake up
> a sleeper as soon as any request is freed costs maybe 30%
> on `dbench 64'.

Is this consistent with results on other IO benchmarks?

--
Daniel
