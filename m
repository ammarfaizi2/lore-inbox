Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319270AbSH2RNr>; Thu, 29 Aug 2002 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319271AbSH2RNr>; Thu, 29 Aug 2002 13:13:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12559
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319270AbSH2RNo>; Thu, 29 Aug 2002 13:13:44 -0400
Date: Thu, 29 Aug 2002 10:15:39 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mike Isely <isely@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <1030635125.7190.116.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208291006070.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That host does have a flag check on the primary channel.
The Seconday has been observed and many people have verified the second
channel works okay in 48-bit.

If you have a system which has a 28-bit limited host, and it has been
openly discussed on lkml for many months, why would one not use the
jumpon.exe from maxtor to prevent such problems.

What I want is details from the last kernel you booted and worked, because
I am positive AC's code does the correct thing.  I was one of the first
people to find the 48-bit bomb in that asic during prototype of the large
drive technology.

So please add more details, and regardless this is a semi-development
thread and nobody else has reported this error.

On 29 Aug 2002, Alan Cox wrote:

> The promise 20265 does need special handling for LBA48 I believe. The
> code should also be handling it correctly. Cc'd to Andre to investigate
> further
> 

Cheers,

Andre Hedrick
LAD Storage Consulting Group

