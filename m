Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135313AbREAOb5>; Tue, 1 May 2001 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbREAObs>; Tue, 1 May 2001 10:31:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135313AbREAObi>; Tue, 1 May 2001 10:31:38 -0400
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
To: mike_phillips@urscorp.com
Date: Tue, 1 May 2001 15:35:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com> from "mike_phillips@urscorp.com" at May 01, 2001 09:52:30 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ubFe-0001jg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) change everything to read/write and friends (the way the driver used to 
> be before the isa_read/write function were introduced)

readb/readw/readl have always worked for ISA bus. They simply avoid the need
for ioremap and are meant for lazy porting

