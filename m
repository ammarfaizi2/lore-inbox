Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFESD2>; Wed, 5 Jun 2002 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSFESD1>; Wed, 5 Jun 2002 14:03:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315721AbSFESD0>;
	Wed, 5 Jun 2002 14:03:26 -0400
Message-ID: <3CFE51E2.3040904@mandrakesoft.com>
Date: Wed, 05 Jun 2002 14:01:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_GENERIC_ISA_DMA
In-Reply-To: <20020605170234.D10293@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Linus, lkml,
>
>The following patch adds support for CONFIG_GENERIC_ISA_DMA, which went
>into the 2.4-ac kernel series prior to 2.5 happening.
>
>  
>


Nice...  I think we want to (over time) start marking drivers that 
require ISA DMA as well, either in the code (if the driver functions 
without ISA DMA, but can use it) or in Config.in.

    Jeff




