Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271413AbRIFQ50>; Thu, 6 Sep 2001 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270823AbRIFQ5G>; Thu, 6 Sep 2001 12:57:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270797AbRIFQ45>; Thu, 6 Sep 2001 12:56:57 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 18:01:01 +0100 (BST)
Cc: saw@saw.sw.com.sg (Andrey Savochkin), wietse@porcupine.org (Wietse Venema),
        matthias.andree@gmx.de (Matthias Andree), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906165051.7EA29BC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 12:50:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f2WT-0008Tp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is not practical. Surely there is an API to find out if an IP
> address connects to the machine itself. If every UNIX system on
> this planet can do it, then surely Linux can do it.

There are a very large number of networking configurations that Unix (here 
meaning 4.*BSD networking or its various stream hacked abuses) cannot
handle. 

How for example do you propose to answer the question for the case
Q: "is this local" A: "it depends on the sender"

With netfilter and transparent proxying active this is entirely possible

Alan
