Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287369AbRL3Jvy>; Sun, 30 Dec 2001 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287370AbRL3Jvo>; Sun, 30 Dec 2001 04:51:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287369AbRL3Jv2>; Sun, 30 Dec 2001 04:51:28 -0500
Subject: Re: midi device release function not being called
To: nospam@mega-nerd.com (Erik de Castro Lopo)
Date: Sun, 30 Dec 2001 10:01:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011230130723.1f27a83f.nospam@mega-nerd.com> from "Erik de Castro Lopo" at Dec 30, 2001 01:07:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KcmR-0000eF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is on linux-2.4.16 on an SMP machine. I have also tried 2.2.20 and 
> found the same problem (file opened O_NONBLOCK and closed with data still
> in the output buffer) there.
> 
> Can someone please shed some light on this?

Looks like a real bug. Test fix queued for 2.2.21pre2
