Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSFRRzv>; Tue, 18 Jun 2002 13:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317524AbSFRRzu>; Tue, 18 Jun 2002 13:55:50 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:52444 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317522AbSFRRzt>;
	Tue, 18 Jun 2002 13:55:49 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206181754.VAA13447@sex.inr.ac.ru>
Subject: Re: NAPI eepro100 bug fixed
To: fxzhang@ict.ac.cn (Zhang Fuxin)
Date: Tue, 18 Jun 2002 21:54:58 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D0EF872.7020007@ict.ac.cn> from "Zhang Fuxin" at Jun 18, 2 05:08:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>     By disabling irq in speedo_poll,we can be sure this won't happen. 
...
>  could you find a flaw?

This nicely will happen when irq arrived on another cpu.

Alexey
