Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315507AbSECAcl>; Thu, 2 May 2002 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315510AbSECAck>; Thu, 2 May 2002 20:32:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27155 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315507AbSECAcg>; Thu, 2 May 2002 20:32:36 -0400
Subject: Re: IDE hotplug support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Fri, 3 May 2002 01:51:25 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        pavel@suse.cz (Pavel Machek), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205030223520.31927-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at May 03, 2002 02:25:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173RID-0005Ii-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The request aliasing effects will be almost for sure disasterous
> > to overall system performance.
> 
> hm. all I want is lots of space. I don't need speed here. What is 
> 'disasterous' here?

Halve the expected throughput and subtract a bit. Since you can put 8
ports on a 3ware card one drive per port at 160Gb a drive I suspect you
don't need master/slave pairs 8)
