Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313676AbSDPNkz>; Tue, 16 Apr 2002 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313677AbSDPNky>; Tue, 16 Apr 2002 09:40:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313676AbSDPNkx>; Tue, 16 Apr 2002 09:40:53 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: terje.eggestad@scali.com (Terje Eggestad)
Date: Tue, 16 Apr 2002 14:58:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel),
        l_girdwood@bitwise.co.uk (Liam Girdwood),
        balbir.singh@wipro.com (BALBIR SINGH),
        olaf@navi.pl (William Olaf Fraczyk),
        wli@holomorphy.com (Lee Irwin III)
In-Reply-To: <1018964120.13527.37.camel@pc-16.office.scali.no> from "Terje Eggestad" at Apr 16, 2002 03:35:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xTTd-0008Va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I seem to recall from theory that the 100HZ is human dependent. Any
> higher and you would begin to notice delays from you input until
> whatever program you're talking to responds. 

Ultimately its because Linus pulled that number out of a hat about ten years
ago. For some workloads 1KHz is much better, for others like giant number
crunching people actually drop it down to about 5..
