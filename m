Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBTMkK>; Tue, 20 Feb 2001 07:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRBTMkA>; Tue, 20 Feb 2001 07:40:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129161AbRBTMjx>; Tue, 20 Feb 2001 07:39:53 -0500
Subject: Re: [lkml]2.2.19pre13: Are there network problem with a low-bandwidth link?
To: thunder7@xs4all.nl
Date: Tue, 20 Feb 2001 12:39:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010220123457.A679@middle.of.nowhere> from "thunder7@xs4all.nl" at Feb 20, 2001 12:34:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VC5A-0006YY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also saw this when my 2.2.19pre12/13 workstation connected to a
> 2.2.19pre8 isdn-router. When downloading a large file via ftp at max
> speed, other connections don't 'get through'.

Its normal tcp behaviour. Its something called the capture effect. You can
mitigate it to an extent by using less buffers, but the buffer count in question
is at the ISP end for a download, or by using smaller windows
