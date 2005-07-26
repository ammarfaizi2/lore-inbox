Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVGZFx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVGZFx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVGZFx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:53:57 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:36833 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261678AbVGZFx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:53:56 -0400
Message-ID: <012401c591a6$9a2e2040$0b00000a@solidwaste>
From: <cutaway@bellsouth.net>
To: "Florin Malita" <fmalita@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com> <1122248869.10835.25.camel@localhost.localdomain> <f8994115050724211071a3dbe1@mail.gmail.com>
Subject: Re: kernel 2.6 speed
Date: Tue, 26 Jul 2005 01:55:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Florin Malita" <fmalita@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Monday, July 25, 2005 12:10 AM
Subject: Re: kernel 2.6 speed


> On 7/24/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > time() isn't a hot
> > path in the real world.
>
> That's what you would expect but I've straced stuff calling
> gettimeofday() in huge bursts every other second. Obviously braindead
> stuff but so is "the real world" most of the time() ... :)

Anything time stamping things it processes many of will call some sort of
time function pretty often.  Could happen frequently with certain classes of
applications.    OS/2's "infoseg" approach was a pretty "high speed low
drag" way to eliminate a trip into the kernel for all but the most esoteric
time requirements.

