Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTBMS1d>; Thu, 13 Feb 2003 13:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTBMS1d>; Thu, 13 Feb 2003 13:27:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34077 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268139AbTBMS1b>; Thu, 13 Feb 2003 13:27:31 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302131837.h1DIbIh14604@devserv.devel.redhat.com>
Subject: Re: EtherLeak generic fix - for feedback & testing.
To: ashishk@caldera.com (Ashish Kalra)
Date: Thu, 13 Feb 2003 13:37:18 -0500 (EST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org, alan@redhat.com,
       akpm@zip.com.au, jgarzik@mandrakesoft.com, linux-net@vger.kernel.org,
       ashishk@sco.com
In-Reply-To: <3.0.32.20030213175200.006cf7cc@indus.asia.caldera.com> from "Ashish Kalra" at Feb 13, 2003 05:52:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a kernel-2.4.13 patch for a "generic" fix for the Etherleak security
> issue and it works without making modifications to network device drivers. 

The right approach is to fix all the drivers so thats what we did. I can
see why a distro fix for an ancient kernel would be done the way you did
though.
