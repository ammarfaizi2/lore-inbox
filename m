Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTBUADx>; Thu, 20 Feb 2003 19:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTBUADl>; Thu, 20 Feb 2003 19:03:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267356AbTBUADF>;
	Thu, 20 Feb 2003 19:03:05 -0500
Message-ID: <3E556F00.30201@pobox.com>
Date: Thu, 20 Feb 2003 19:12:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@badula.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: UP local APIC is deadly on SMP Athlon
References: <Pine.LNX.4.44.0302191458160.29393-100000@guppy.limebrokerage.com>
In-Reply-To: <Pine.LNX.4.44.0302191458160.29393-100000@guppy.limebrokerage.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> A UP kernel compiled with CONFIG_X86_LOCAL_APIC=y dies a very horrible
> death on an SMP Athlon motherboard (Tyan S2462 and S2468), flooding the
> console with the following messages:

IMO just assume this option is just broken, unless you absolutely need it.

Red Hat ships UP kernels with this option disabled, because either the 
code, the BIOS, or both are typically broken.

	Jeff



