Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSLDNPK>; Wed, 4 Dec 2002 08:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSLDNPK>; Wed, 4 Dec 2002 08:15:10 -0500
Received: from 212-170-21-172.uc.nombres.ttd.es ([212.170.21.172]:42646 "EHLO
	omega.resa.es") by vger.kernel.org with ESMTP id <S266660AbSLDNPJ>;
	Wed, 4 Dec 2002 08:15:09 -0500
Date: Wed, 4 Dec 2002 14:22:35 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
Message-ID: <20021204132235.GA32090@omega.resa.es>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DEDF543.51C80677@uni-konstanz.de> <1039009531.15353.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039009531.15353.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Pedro Larroy <piotr@omega.resa.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 01:45:31PM +0000, Alan Cox wrote:
> On Wed, 2002-12-04 at 12:29, Kay Diederichs wrote:
> > the subject says it all: 
> > 
> > if I use the powersaving module amd76x_pm then the time is not kept. The
> > hardware is Asus A7M266-D with 2 MP1900 processors, BIOS is 1004 (but I
> > tried later BIOS versions as well).
> 
> Boot with "notsc". Unfortunately I dont think there is a way I can make
> the module turn off tsc at runtime.
> 

Hi
 
I've had the same issues and a lot of overruns in eth0 plus bandwith
decreased to one tenth. Does this happen because disconnecting the athlon
FSB makes impossible for the ethernet interface to perform dma on memory?

Regards.
-- 
O   _____________________________________________________________   O
|  /-| Pedro Larroy Tovar. PiotR | http://omega.resa.es/piotr  |-\  |
| /--|            No MS-Office attachments please.             |--\ |
o-|--|              e-mail: piotr@omega.resa.es                |--|-o 
   \-|   finger piotr@omega.resa.es for public key and info    |-/  
    -------------------------------------------------------------
