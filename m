Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSCUP75>; Thu, 21 Mar 2002 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSCUP7s>; Thu, 21 Mar 2002 10:59:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28170 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312380AbSCUP7h>; Thu, 21 Mar 2002 10:59:37 -0500
Subject: Re: last write to drive issued with write cache off?
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Thu, 21 Mar 2002 16:15:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C9A02CE.A177F8BC@nortelnetworks.com> from "Chris Friesen" at Mar 21, 2002 10:57:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o5EB-0005aS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "To prevent loss of customer data, it is recommended that the last write access
> before power off be issued after setting the write cache off."

Standard 2.4 doesn't do this. 2.4.19-ac issues cache flushes.

