Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315594AbSEGOZN>; Tue, 7 May 2002 10:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSEGOZM>; Tue, 7 May 2002 10:25:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36880 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315594AbSEGOZL>; Tue, 7 May 2002 10:25:11 -0400
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
To: naclos@andyc.dyndns.org (Andy Carlson)
Date: Tue, 7 May 2002 15:42:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205061106050.2878-100000@ancyc> from "Andy Carlson" at May 06, 2002 11:08:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1756Ax-0007gM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do the userspace tools still depend on Redhat or a derivative?  If this 

Never have done.

> is true, I would say that Tux should stay out of the kernel.  It is 
> aggravating when you want to try something new, and run into 
> dependencies on specific distros.

Tux has a lot of other things that make it questionable for merging -
incredibly so for 2.4 - it sticks its fingers into task structs, dcache
and other places.
