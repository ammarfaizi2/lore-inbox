Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTJJRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJJRgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:36:21 -0400
Received: from yakov.inr.ac.ru ([193.233.7.111]:31921 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S262987AbTJJRgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:36:10 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310101735.VAA22067@yakov.inr.ac.ru>
Subject: Re: patch to implement RFC3517 in linux 2.4.22
To: doug.leith@may.ie
Date: Fri, 10 Oct 2003 21:35:48 +0400 (MSD)
Cc: davem@redhat.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
In-Reply-To: <006c01c38f50$7bc26940$0603dc0a@hamilton.local> from "Douglas Leith" at  =?ISO-8859-1?Q?=20=EF?=
	=?ISO-8859-1?Q?=CB=D4?= 10, 2003 06:03:51 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The new code marks packets in sack holes as lost as soon as three or more packets with higher sequence numbers are sacked and these will then be immediately retransmitted - this should mean that retransmission of lost packets generally happens earlier and recovery is faster.  

What those chunks of code which you killed with IsReno() do to your
opinion?

Alexey

PS Please, try to format mails more sanely. This one is close to unreadable.

Alexey
