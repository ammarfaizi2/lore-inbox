Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBNVJr>; Wed, 14 Feb 2001 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRBNVJi>; Wed, 14 Feb 2001 16:09:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129110AbRBNVJ1>; Wed, 14 Feb 2001 16:09:27 -0500
Subject: Re: ECN for servers ?
To: jgarzik@mandrakesoft.mandrakesoft.com (Jeff Garzik)
Date: Wed, 14 Feb 2001 21:09:39 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010214145253.30758C-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Feb 14, 2001 02:53:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T9BG-00064f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Con: people behind broken firewalls can't connect.
> 
> Since you can use ICMP to tunnel data, a lot of security ppl are
> reluctant to stop filtering ICMP :/

ICMP isnt the problem. Some of the load balancers and proxy setups didnt
allow ECN frames through. ICMP blocking just breaks path mtu discovery and
accessing the site via IPsec, via mobile ip and a few other things.

And you can tunnel data over ack sequence spaces, IP over http is trivial.
There are reasons proper proxy setups have passwords outgoing and do not let
any control data/header info across untouched

