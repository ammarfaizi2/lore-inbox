Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbULFR1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbULFR1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbULFR1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:27:24 -0500
Received: from 4.Red-80-32-108.pooles.rima-tde.net ([80.32.108.4]:25216 "EHLO
	gimli") by vger.kernel.org with ESMTP id S261586AbULFR1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:27:13 -0500
Message-ID: <41B4971E.6060401@sombragris.com>
Date: Mon, 06 Dec 2004 18:30:06 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx driver large integer warning
References: <41B3A683.8060008@sombragris.com> <1102339898.13423.28.camel@localhost.localdomain>
In-Reply-To: <1102339898.13423.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Add (dma_addr_t) casts and it will go away. The compiler just wants to
>know you mean it.
>  
>
Sure, but the 39 bit variable is only used when the type of dma_addr_t 
is u64. I think that is more clean to put this assignement inside the if 
block, like the rest of the CONFIG_HIGHMEM64G code. Anyway the 
(dma_addr_t) cast can be added too.

¿how you would solve this?

Cheers,
MaF

