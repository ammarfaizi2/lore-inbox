Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSCGO1Z>; Thu, 7 Mar 2002 09:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSCGO1O>; Thu, 7 Mar 2002 09:27:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57358 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292593AbSCGO05>; Thu, 7 Mar 2002 09:26:57 -0500
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
To: terje.eggestad@scali.com (Terje Eggestad)
Date: Thu, 7 Mar 2002 14:41:21 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi),
        greearb@candelatech.com (Ben Greear),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <1015510496.4373.58.camel@pc-16.office.scali.no> from "Terje Eggestad" at Mar 07, 2002 03:14:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iz57-0002SW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a CPU that begin throttling it usually cut the CPU clock in
> half and the rdtsc counter count half a fast.

They normally adjust the STPCLK which is just fine. I've only seen a few
laptops that do it other ways. More fun are people running mixed 300/450
BP6 boards where the tsc varies by cpu
