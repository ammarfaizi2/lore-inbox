Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRCLSNp>; Mon, 12 Mar 2001 13:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbRCLSNf>; Mon, 12 Mar 2001 13:13:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:27921 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130532AbRCLSNT>;
	Mon, 12 Mar 2001 13:13:19 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103121812.VAA09627@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
To: manfred@colorfullife.COM (Manfred Spraul)
Date: Mon, 12 Mar 2001 21:12:33 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AACFC6A.67E570AA@colorfullife.com> from "Manfred Spraul" at Mar 12, 1 08:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> * davem's patch breaks apps that assume that write(,PIPE_BUF) after
> poll(POLLOUT) never blocks, even for blocking pipes.

Pardon, but PIPE_BUF <= PAGE_SIZE yet, so that fears have no reasons.

Alexey
