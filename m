Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbQKGMRr>; Tue, 7 Nov 2000 07:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKGMRh>; Tue, 7 Nov 2000 07:17:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30327 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129662AbQKGMRa>; Tue, 7 Nov 2000 07:17:30 -0500
Subject: Re: rdtsc to mili secs?
To: antony@mira.net (Antony Suter)
Date: Tue, 7 Nov 2000 12:18:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A078C65.B3C146EC@mira.net> from "Antony Suter" at Nov 07, 2000 04:00:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7ht-0007Kv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This issue, and all related issues, need to be taken care of for all
> speed
> changing CPUs from Intel, AMD and Transmeta. Is the answer of "howto

Sensibly configured power saving/speed throttle systems do not change the
frequency at all. The duty cycle is changed and this controls the cpu 
performance but the tsc is constant

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
