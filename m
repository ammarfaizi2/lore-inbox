Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264168AbTCXMCW>; Mon, 24 Mar 2003 07:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264170AbTCXMCW>; Mon, 24 Mar 2003 07:02:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65466 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264168AbTCXMCV>; Mon, 24 Mar 2003 07:02:21 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303241213.h2OCD6u21467@devserv.devel.redhat.com>
Subject: Re: [IDE SiI680] throughput drop to 1/4
To: samel@mail.cz (Vitezslav Samel)
Date: Mon, 24 Mar 2003 07:13:06 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), andre@linux-ide.org (Andre Hedrick),
       linux-kernel@vger.kernel.org
In-Reply-To: <20030324072910.GA16596@pc11.op.pod.cz> from "Vitezslav Samel" at Mar 24, 2003 08:29:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Recently I tried to figure out in 2.5.65, why throughput on my disk which
> hangs on Silicon Image 680 dropped to 1/4 compared to 2.4.21-pre5, but didn't
> found anything useful. Are there any known issues with this driver?

The same code in both cases. Its quite likely the problem is higher up in
the block or filesystem layer. It might also be a general IDE layer bug

What does performance look like on your other disk between
2.4.21pre/2.5.65 ?
