Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277702AbRJICWF>; Mon, 8 Oct 2001 22:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277704AbRJICVz>; Mon, 8 Oct 2001 22:21:55 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:26892 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277702AbRJICVm>; Mon, 8 Oct 2001 22:21:42 -0400
Message-Id: <200110090221.f992LwY63329@aslan.scsiguy.com>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: "David M. Grimes" <dmgrime@appliedtheory.com>,
        Jim Crilly <noth@noth.is.eleet.ca>, Rob Turk <r.turk@chello.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx panic 
In-Reply-To: Your message of "Sun, 07 Oct 2001 16:48:18 +0200."
             <20011007163158.Q1555-100000@gerard> 
Date: Mon, 08 Oct 2001 20:21:58 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The right fix might well not apply to the driver code. Btw, I donnot plan
>to look into the problem, as Justin may just be studying it, in my
>guessing.  I just wanted to suggest to also look into upper layers and not
>to only focus on the low-level driver.

I can't really speak to what is an acceptable number of segments
for Linux (I just copied what the old driver did), but the aic7xxx
driver does export its current limit to upper layers and that limit
should be honored.

--
Justin
