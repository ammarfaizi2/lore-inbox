Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSICNTl>; Tue, 3 Sep 2002 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSICNTl>; Tue, 3 Sep 2002 09:19:41 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:27522 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318770AbSICNTl>;
	Tue, 3 Sep 2002 09:19:41 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209031322.RAA02182@sex.inr.ac.ru>
Subject: Re: TCP Segmentation Offloading (TSO)
To: taka@valinux.co.jp (Hirokazu Takahashi)
Date: Tue, 3 Sep 2002 17:22:37 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, davem@redhat.com
In-Reply-To: <20020903.220302.26270018.taka@valinux.co.jp> from "Hirokazu Takahashi" at Sep 3, 2 10:03:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> We can see skb_checksum() calls csum_partial() againt each page in skb.

Good point...

Dave, look, he says we will oops when sendfiling the last byte of a page,
and will have to call skb_checksum().

Alexey
