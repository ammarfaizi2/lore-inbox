Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTIDRNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbTIDRNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:13:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265270AbTIDRNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:13:37 -0400
Message-ID: <3F5772B2.402@pobox.com>
Date: Thu, 04 Sep 2003 13:13:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
References: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I think that in the 2.7.x timeframe, the right thing to do is definitely:
>  - move towards using "struct resource" and "ioremap_resource()"
>  - make resource sizes potentially be larger (ie use "u64" instead of 
>    "unsigned long")


Would still be nice to have a sysdata or struct device pointer in struct 
resource, then.  I'm not a fan of wacky 
bus-info-encoded-in-another-number schemes.

	Jeff



