Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293143AbSCEBks>; Mon, 4 Mar 2002 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293148AbSCEBkj>; Mon, 4 Mar 2002 20:40:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5902 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293143AbSCEBkf>; Mon, 4 Mar 2002 20:40:35 -0500
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
To: rml@tech9.net (Robert Love)
Date: Tue, 5 Mar 2002 01:55:05 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <1015289912.882.45.camel@phantasy> from "Robert Love" at Mar 04, 2002 07:58:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i4AT-0001Rq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Better?

Not really

> +#if CONFIG_SMP || CONFIG_PREEMPT

#if [expression]

try

#if defined(a) || defined(b)

Interesting that the difference pre-empt makes is so large you didnt notice
you hadn't re-enabled it ;)

Alan
--
   "Nothing would please me more than being able to hire ten programmers 
      and deluge the hobby market with good software." -- Bill Gates 1976

   We are still waiting ....

