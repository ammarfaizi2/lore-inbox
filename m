Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSHLRac>; Mon, 12 Aug 2002 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSHLRab>; Mon, 12 Aug 2002 13:30:31 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:57487 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318760AbSHLRaD>;
	Mon, 12 Aug 2002 13:30:03 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208121732.VAA18612@sex.inr.ac.ru>
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
To: davem@redhat.com (David S. Miller)
Date: Mon, 12 Aug 2002 21:32:46 +0400 (MSD)
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
In-Reply-To: <20020812.025453.114975744.davem@redhat.com> from "David S. Miller" at Aug 12, 2 02:54:53 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Aparently something is wrong with the checksums.

The problem is that checksum in tcpdump is OK.
This smells really bad.

I feel you have to hunt where exactly the segment is dropped
and TCPInErrs is incremented.

> Hmmm, do you have messages that say "hw tcp v4 csum failed"

It is dumb realtek card, so checksum is calculated in software.

Alexey
