Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSGPQ5t>; Tue, 16 Jul 2002 12:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317889AbSGPQ5s>; Tue, 16 Jul 2002 12:57:48 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:32711 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317888AbSGPQ5s>;
	Tue, 16 Jul 2002 12:57:48 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207161700.VAA14214@sex.inr.ac.ru>
Subject: Re: Networking question
To: Jack.Bloch@icn.siemens.COM (Bloch Jack)
Date: Tue, 16 Jul 2002 21:00:15 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <180577A42806D61189D30008C7E632E8793998@boca213a.boca.ssc.siemens.com> from "Bloch, Jack" at Jul 16, 2 07:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the priority of the softirq daemon or ensure that it is always awoken when a
> netif_rx is called?

You should suppound it with local_bh_disable()/enable(), when using
from process context.

Alexey

