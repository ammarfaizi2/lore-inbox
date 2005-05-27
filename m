Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVE0Opm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVE0Opm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVE0Opm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:45:42 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:36106 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S261771AbVE0Opi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:45:38 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Ian Leonard'" <ian@smallworld.cx>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.30 - USB serial problem
Date: Fri, 27 May 2005 10:45:34 -0400
Organization: Connect Tech Inc.
Message-ID: <029101c562ca$bd095b30$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <42960CCA.5020703@smallworld.cx>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> We recently upgraded from 2.4.24 to 2.4.28 and the problem described 
> below appeared. I have tested it on 2.4.30 and the fault still exists.
[snip]
> Examining the packet that caused the problem showed it was 
> very similar 
> to the others but it contained 0x0a. This obviously stuck out 
> as being a 
> candidate for some sort of translation problem.

That's a software flow control character, have you turned off software
flow control?

..Stu

