Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131882AbRCVAyT>; Wed, 21 Mar 2001 19:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131884AbRCVAyI>; Wed, 21 Mar 2001 19:54:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30226 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131882AbRCVAx7>; Wed, 21 Mar 2001 19:53:59 -0500
Subject: Re: hostid derived from...
To: kern@e-zebra.net
Date: Thu, 22 Mar 2001 00:55:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103221210090.15305-100000@wolf.ezebra.net> from "kern@e-zebra.net" at Mar 22, 2001 12:12:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ftO5-0001VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how does linux provide the hostid string?

Its up to the C library

> on a sun box this is a guaranteed unique identifier, since AFAIK
> intel architecture does not have this unique identifier can 
> two linux boxes end up with same hostid by chance?

Easily. hostid is generally only useful to proprietary license managers so
its a relatively minor issue in the Linux world. You can set it by sticking
the data you want in /etc/hostid

