Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSGQRcf>; Wed, 17 Jul 2002 13:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSGQRcf>; Wed, 17 Jul 2002 13:32:35 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:58824 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315856AbSGQRcf>;
	Wed, 17 Jul 2002 13:32:35 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207171735.VAA20796@sex.inr.ac.ru>
Subject: Re: Is TCP CA_LOSS to CA_RECOVERY possible
To: spy9599@yahoo.COM (spy9599)
Date: Wed, 17 Jul 2002 21:35:06 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020717161834.12994.qmail@web14806.mail.yahoo.com> from "spy9599" at Jul 17, 2 08:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> are lost again. Ideally the TCP sender should just
> enter fast retransmit and fast recovery,

While retransmitting after timeout and until all the segments sent
to the time when retrasmit started, fast retransmit is prohibited
by Floyd's block. Look into RFC2582 for explanations, keyword is "send_high".

Alexey
