Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268883AbRG0RYj>; Fri, 27 Jul 2001 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbRG0RY3>; Fri, 27 Jul 2001 13:24:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268883AbRG0RYL>; Fri, 27 Jul 2001 13:24:11 -0400
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: samudrala@us.ibm.com (Sridhar Samudrala)
Date: Fri, 27 Jul 2001 18:25:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au, samudrala@us.ibm.com
In-Reply-To: <Pine.LNX.4.21.0107270946420.14246-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Jul 27, 2001 10:10:22 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QBMf-00066p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> The documentation on HOWTO use this patch and the test results which show an
> improvement in connection rate for higher priority classes can be found at our
> project website.
>         http://oss.software.ibm.com/qos
> 
> We would appreciate any comments or suggestions.

Simple question.

How is this different from having a single userspace thread in your
application which accepts connections as they come in and then hands them
out in an order it chooses, if need be erorring and closing some ?

Alan
