Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136730AbRECKoX>; Thu, 3 May 2001 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136751AbRECKoN>; Thu, 3 May 2001 06:44:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7942 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136730AbRECKoD>; Thu, 3 May 2001 06:44:03 -0400
Subject: Re: T/TCP
To: patrizio@dada.it (Patrizio Bruno)
Date: Thu, 3 May 2001 11:48:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105031223540.18099-100000@blacksheep.at.dada.it> from "Patrizio Bruno" at May 03, 2001 12:33:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vGeS-0005Lu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the T/TCP concept, but I sadly found that the linux's tcp/ip stack doesn't
> support it, basing on what stevens says, that's because of a buggy tcp/ip
> implementation, infact the standard tcp/ip should can send

People have since shown T/TCP has other problems and to my knowledge nobody
has bothered to do the work to improve the protocol. T/TCP also contrary to
a lot of belief does involve violating the original TCP specification and
sending data into an unadvertisd and possibly zero window.

Alan

