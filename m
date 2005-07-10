Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVGJAr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVGJAr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVGJArz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 20:47:55 -0400
Received: from [195.23.16.24] ([195.23.16.24]:7320 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261802AbVGJArz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 20:47:55 -0400
Message-ID: <1120956292.42d06f842c96f@webmail.grupopie.com>
Date: Sun, 10 Jul 2005 01:44:52 +0100
From: "" <pmarques@grupopie.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "" <azarah@nosferatu.za.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       "" <linux-kernel@vger.kernel.org>, "" <torvalds@osdl.org>,
       "" <christoph@lameter.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org>  <20050708214908.GA31225@taniwha.stupidest.org>  <20050708145953.0b2d8030.akpm@osdl.org>  <1120928891.17184.10.camel@lycan.lan>  <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org>
In-Reply-To: <1120933916.3176.57.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.88.189
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven <arjan@infradead.org>:
> [...]
> it's a config option. Some distros ship 100 already, others 1000, again
> others will do 250. What does it matter?
> (Although I still prefer 300 over 250 due to the 50/60 thing)

I just want to point out that while a frequency of 300Hz has good dividers, it
has a lousy period of 3.33... ms. It seems easier to make calculations with a
period of 4 ms per jiffy (250Hz).

The rest of the discussion I'll leave to others as I have no strong feelings
either way.

--
Paulo Marques

