Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUC2Dla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUC2Dla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:41:30 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:22929 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262585AbUC2Dl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:41:28 -0500
Message-ID: <07df01c4153c$8b5a79c0$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Paul Mackerras" <paulus@samba.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <048e01c413b3$3c3cae60$fc82c23f@pc21> <16487.27405.198869.969004@cargo.ozlabs.ibm.com>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sun, 28 Mar 2004 19:18:39 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Paul Mackerras" <paulus@samba.org>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Sunday, March 28, 2004 4:17 PM
Subject: Re: Kernel support for peer-to-peer protection models...


> Ivan Godard writes:
>
> > 3) flat, unified virtual addresses (64 bit) so that pointers, including
> > inter-space pointers, have the same representation in all spaces
>
> How are you going to implement fork() ?

The usual COW using the page tables. The child keeps the same code space but
gets a new data space. I expect that specialized versions of fork will give
explicit control over which space the child gets, but in comman usage no one
cases just as no one cares which PID it gets.

Ivan


