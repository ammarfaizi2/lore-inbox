Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293104AbSCEA64>; Mon, 4 Mar 2002 19:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293103AbSCEA6g>; Mon, 4 Mar 2002 19:58:36 -0500
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:13944 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S293096AbSCEA6Z>; Mon, 4 Mar 2002 19:58:25 -0500
Message-ID: <002701c1c3e0$7f5a27b0$0501a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: <jt@hpl.hp.com>, <paulus@samba.org>, <linux-ppp@vger.kernel.org>,
        "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com>
Subject: Re: PPP feature request (Tx queue len + close)
Date: Tue, 5 Mar 2002 00:55:51 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tx queue length
> ---------------
> Problem : IrDA does its buffering (IrTTP is a sliding window
> protocol). PPP does its buffering (1 packet in ppp_generic +
> dev->tx_queue_len = 3). End result : a large number of packets queued
> for transmissions, which result in some network performance issues.
>
> Solution : could we allow the PPP channel to overwrite
> dev->tx_queue_len ?
> This is similar to the channel beeing able to set the MTUs and
> other parameters...

somebody please correct me if i am wrong but if the
txqueuelen not set from userspace from
ifconfig ?


