Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSA0WnA>; Sun, 27 Jan 2002 17:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288944AbSA0Wmu>; Sun, 27 Jan 2002 17:42:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25099 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288914AbSA0Wmj>; Sun, 27 Jan 2002 17:42:39 -0500
Subject: Re: PROBLEM: high system usage / poor SMP network performance
To: v.sweeney@barrysworld.com (Vincent Sweeney)
Date: Sun, 27 Jan 2002 22:54:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004701c1a781$387d2570$0201010a@frodo> from "Vincent Sweeney" at Jan 27, 2002 10:23:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UyCO-0002zE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
>     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle

The important bit here is     ^^^^^^^^ that one. Something is causing 
horrendous lock contention it appears. Is the e100 driver optimised for SMP 
yet ? Do you get better numbers if you use the eepro100 driver ?
