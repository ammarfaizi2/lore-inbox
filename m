Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSGRPPS>; Thu, 18 Jul 2002 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSGRPPS>; Thu, 18 Jul 2002 11:15:18 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:30592 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318122AbSGRPPR>;
	Thu, 18 Jul 2002 11:15:17 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207181517.TAA00426@sex.inr.ac.ru>
Subject: Re: Networking question
To: Jack.Bloch@icn.siemens.com (Bloch, Jack)
Date: Thu, 18 Jul 2002 19:17:45 +0400 (MSD)
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org
In-Reply-To: <180577A42806D61189D30008C7E632E87939A6@boca213a.boca.ssc.siemens.com> from "Bloch, Jack" at Jul 18, 2 11:11:31 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> code code of netif_rx_ni seems to be logically the most correct way since it
> will trigger do_softirq directly after the call to netif_rx.

Yes, of course. I simply forgot that _ni was evetually added.

Alexey
