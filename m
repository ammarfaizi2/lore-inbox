Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSEXOWN>; Fri, 24 May 2002 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSEXOWM>; Fri, 24 May 2002 10:22:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50699 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314223AbSEXOWM>; Fri, 24 May 2002 10:22:12 -0400
Subject: Re: Compiling 2.2.19 with -O3 flag
To: intellectcrew@yahoo.com (samson swanson)
Date: Fri, 24 May 2002 15:42:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020524065153.15644.qmail@web14309.mail.yahoo.com> from "samson swanson" at May 23, 2002 11:51:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGGw-0006NO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to ask when compiling with -O3 flag on a
> kernel such as 2.2.19, what harm / side effect will I
> feel later on if any? will i loose speed in other area's?

Bench it and see. From my own experience -O3 made the kernel a lot larger
and reduced overall performance - in part because the kernel already 
explicitly figures out what it wants inlined.

Interestingly enough -Os outperformed -O2
