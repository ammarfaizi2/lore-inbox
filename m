Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbRFUN2Q>; Thu, 21 Jun 2001 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbRFUN2G>; Thu, 21 Jun 2001 09:28:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264954AbRFUN1v>; Thu, 21 Jun 2001 09:27:51 -0400
Subject: Re: Is it useful to support user level drivers
To: balbir_soni@yahoo.com (Balbir Singh)
Date: Thu, 21 Jun 2001 14:27:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010621124337.44506.qmail@web13605.mail.yahoo.com> from "Balbir Singh" at Jun 21, 2001 05:43:37 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D4UP-0001Ll-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree, the idea is to clear the IRQ in kernel space
> and then deliver to user level programs interested
> using a signal (Real time SIGINT or something similar)
> If somebody is interested I could in sometime come
> up with what I have in mind and send it to this list,
> accept comments and criticism.

I think you should yes. The XFree86 people for one are trying to find a way
to handle vertical blank interrupts nicely
