Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSEVQFE>; Wed, 22 May 2002 12:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316231AbSEVQDt>; Wed, 22 May 2002 12:03:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5907 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316229AbSEVQDo>; Wed, 22 May 2002 12:03:44 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
To: Martin.Bligh@us.ibm.com
Date: Wed, 22 May 2002 17:23:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ahu@ds9a.nl (bert hubert),
        znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org
In-Reply-To: <1404136612.1022057787@[10.10.2.3]> from "Martin J. Bligh" at May 22, 2002 08:56:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AYtg-00028d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you outline the changes in this area? I want to make sure we're
> not all fighting the same problems seperately ;-) I know bounce
> buffers is one large element of that, though I believe you still
> only go up to 4Gb, unless I'm mistaken?

Bounce buffer handling 

> > To go past 16Gb you need highmem mapped page tables which I'm 
> > pretty sure did not  make it in.
> 
> You need it earlier than that if you have many large tasks (4Gb
> or so).

That I can believe
