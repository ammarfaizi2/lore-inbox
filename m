Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267314AbRGZL6H>; Thu, 26 Jul 2001 07:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbRGZL54>; Thu, 26 Jul 2001 07:57:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267314AbRGZL5q>; Thu, 26 Jul 2001 07:57:46 -0400
Subject: Re: IGMP join/leave time variability
To: nat.ersoz@myrio.com (Nat Ersoz)
Date: Thu, 26 Jul 2001 12:59:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Nat Ersoz" at Jul 25, 2001 07:04:32 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PjnB-0003bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> ASAP with respect to the user mode calls.
> 1. What would be the harm if I set IGMP_Initial_Report_Delay to something
> very small like 5 to 10 (jiffies)?  No need for net_random() I'de expect in
> that case?

Read the IGMP RFC documents they discuss in detail the cases where time
delays and randomness are needed and important. 
