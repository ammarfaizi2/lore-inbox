Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314136AbSDQVyU>; Wed, 17 Apr 2002 17:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSDQVyT>; Wed, 17 Apr 2002 17:54:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60422 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314136AbSDQVyS>; Wed, 17 Apr 2002 17:54:18 -0400
Subject: Re: Hyperthreading
To: Martin.Bligh@us.ibm.com (Martin J. Bligh)
Date: Wed, 17 Apr 2002 23:12:00 +0100 (BST)
Cc: jbourne@MtRoyal.AB.CA (James Bourne), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org
In-Reply-To: <1833210000.1019077852@flay> from "Martin J. Bligh" at Apr 17, 2002 02:10:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xxei-0003ES-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And, you've gotta like this line:
> > Total of 4 processors activated (14299.95 BogoMIPS).
> 
> Before you get too excited about that, how much performance boost do 
> you actually get by turning on Hyperthreading? ;-)

10-30% typically. I've actually seen code where you can't measure the
improvement because the main cpu code path is precision tuned to the 
cache...
