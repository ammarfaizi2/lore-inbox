Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbSLLUCx>; Thu, 12 Dec 2002 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbSLLUCx>; Thu, 12 Dec 2002 15:02:53 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11689 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267424AbSLLUCw>; Thu, 12 Dec 2002 15:02:52 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200212122010.gBCKAYX21292@devserv.devel.redhat.com>
Subject: Re: [PATCH 2.4-ac] Via 8233 Sound not working
To: reddog83@chartermi.net (Nathaniel Russell)
Date: Thu, 12 Dec 2002 15:10:34 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0212121459570.3368-300000@reddog.example.net> from "Nathaniel Russell" at Dec 12, 2002 03:08:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Humm I didnt build it SMP so missed that case I guess. CHange to

	synchronize_irq()


