Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHINb3>; Fri, 9 Aug 2002 09:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHINb3>; Fri, 9 Aug 2002 09:31:29 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:48516 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S293203AbSHINb2>;
	Fri, 9 Aug 2002 09:31:28 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208091334.RAA04694@sex.inr.ac.ru>
Subject: Re: flushing arp buffer -- why __skb_dequeue rather than __skb_dequeue_tail
To: cfriesen@nortelnetworks.COM (Chris Friesen)
Date: Fri, 9 Aug 2002 17:34:37 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D52EDD6.75150466@nortelnetworks.com> from "Chris Friesen" at Aug 9, 2 02:45:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> __skb_dequeue_tail()?  The latter would result in FIFO

Hmmm... actually, it is supposed to be FIFO now. :-)
skb_dequeue_tail would result in lifo.

Probaly, you deal with an older kernel, I remember we had a bug here.

Alexey
