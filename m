Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSARUNh>; Fri, 18 Jan 2002 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290798AbSARUN1>; Fri, 18 Jan 2002 15:13:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1546 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290797AbSARUNP>; Fri, 18 Jan 2002 15:13:15 -0500
Subject: Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
To: moensd@xs4all.be (Didier Moens)
Date: Fri, 18 Jan 2002 20:25:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, Nicolas.Aspert@epfl.ch (Nicolas Aspert)
In-Reply-To: <3C487E68.1000404@xs4all.be> from "Didier Moens" at Jan 18, 2002 08:58:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RfZf-0007nk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
> invoked, both in terminal and in X. APM functions perfectly when agpgart 
> is absent.

Looks like the author forgot to set the suspend/resume methods in the
structure to the generic ones
