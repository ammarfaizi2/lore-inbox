Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSFTOfQ>; Thu, 20 Jun 2002 10:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSFTOfP>; Thu, 20 Jun 2002 10:35:15 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:51942 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S314584AbSFTOfO>;
	Thu, 20 Jun 2002 10:35:14 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206201433.SAA19898@sex.inr.ac.ru>
Subject: Re: [PATCH] Replace timer_bh with tasklet
To: rml@tech9.net (Robert Love)
Date: Thu, 20 Jun 2002 18:33:02 +0400 (MSD)
Cc: davem@redhat.com, george@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <1024538005.922.70.camel@sinai> from "Robert Love" at Jun 19, 2 06:53:25 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> TIMER_BH is the only BH left as far as I know.

:-) If so, then timer_bh can be removed too. This means that
all the serialization is already broken and things cannot become worse. :-)

Alexey
