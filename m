Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137143AbREKOLA>; Fri, 11 May 2001 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137144AbREKOKt>; Fri, 11 May 2001 10:10:49 -0400
Received: from mercury.ukc.ac.uk ([129.12.21.10]:5260 "EHLO mercury.ukc.ac.uk")
	by vger.kernel.org with ESMTP id <S137143AbREKOKq>;
	Fri, 11 May 2001 10:10:46 -0400
Date: Fri, 11 May 2001 15:09:46 +0100 (BST)
From: Leonid Timochouk <L.A.Timochouk@ukc.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: FIXED: Problem with dmfe
In-Reply-To: <E14yHEE-0000kr-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105111458310.19664-100000@myrtle.ukc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It could be an IRQ routing problem. It could be a dmfe driver
> problem. Does     
> using the tulip driver in 2.4.x with it make it any happier ?                   

The problem was fixed by using the 2.4-specific driver (dm9xs.c) provided
by Davicom at

http://www.davicom.com.tw/download/download_driver.asp

instead of dmfe.c. I am still not sure what was the exact cause of trouble
with the original driver.

Dr. Leonid Timochouk
Computing Laboratory
University of Kent at Canterbury, England

