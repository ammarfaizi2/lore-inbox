Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290946AbSBRTr3>; Mon, 18 Feb 2002 14:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290833AbSBRTrU>; Mon, 18 Feb 2002 14:47:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39431 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287449AbSBRTrM>; Mon, 18 Feb 2002 14:47:12 -0500
Subject: Re: want ip identification enabled
To: xinwenfu@cs.tamu.edu (Xinwen - Fu)
Date: Mon, 18 Feb 2002 20:01:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.10.10202181335470.8734-100000@dogbert> from "Xinwen - Fu" at Feb 18, 2002 01:39:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ctyP-0006co-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Now I get that on some OS, for UDP and ICMP packets, the ip
> identification fields are not set. 
> 
> 	But I want that every packet has an id. Is there any emthod to get
> the current system glocal variable "ip_id" and change it or 
> enable UDP and ICMP ip identification number somewhere?

IP id is only required on packets that do not have the dont fragment flag
set. Don't rely on it for anything else.


Alan
