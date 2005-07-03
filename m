Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVGCTGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVGCTGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGCTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:06:51 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:4510 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261497AbVGCTGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:06:40 -0400
Message-ID: <005801c58009$b1a13400$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: <linux-kernel@vger.kernel.org>
References: <200507012258_MC3-1-A340-3A81@compuserve.com> <200507021456.40667.vda@ilport.com.ua>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Date: Sun, 3 Jul 2005 15:59:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
To: "Chuck Ebbert" <76306.1226@compuserve.com>; <cutaway@bellsouth.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>; "Coywolf Qi Hunt"
<coywolf@gmail.com>
Sent: Saturday, July 02, 2005 07:56
Subject: Re: [RFC] exit_thread() speedups in x86 process.c


>
> 80/20 rule says that 80% of code runs 20% of time,
> thus we need only __fast. Everything else will be by default __slow.
> (IOW: normal .text section is __slow, no need to add another one).

What makes you think __fast implies everything else should necessarily be
"slow"?

You might want to entertain the idea that some systems employ several
different speeds of memory where the penalty for making such assumptions
could be extreme if the bootstrap were to metric available memory regions
for response and locate portions of the system accordingly someday.

