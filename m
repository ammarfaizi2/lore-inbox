Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCOXoS>; Fri, 15 Mar 2002 18:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCOXoI>; Fri, 15 Mar 2002 18:44:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293521AbSCOXny>; Fri, 15 Mar 2002 18:43:54 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davem@redhat.com (David S. Miller)
Date: Fri, 15 Mar 2002 23:59:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davids@webmaster.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020315.153705.111545634.davem@redhat.com> from "David S. Miller" at Mar 15, 2002 03:37:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m1bl-000554-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A RST must, in order to function properly, be as simple and non-error
> prone as possible.  MD5 signatures are totally against that.

Duh wakey wakey Dave

> Either use IPSEC or fix its' deficiencies.

What do you think Ipsec does with an RST frame with an incorrect IP-AH
MD5 signature ? Exactly the same thing.

I'm not saying the RFC is a good idea (tho its a needed patch to use Linux
for backbone routing sanely with most vendors BGP kit). Your argument about
the RST frame is however pure horseshit

Alan
