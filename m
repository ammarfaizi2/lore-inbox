Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264332AbRFLLw1>; Tue, 12 Jun 2001 07:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264334AbRFLLwR>; Tue, 12 Jun 2001 07:52:17 -0400
Received: from motgate.mot.com ([129.188.136.100]:45468 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id <S264332AbRFLLwJ>;
	Tue, 12 Jun 2001 07:52:09 -0400
Message-Id: <3B2601DC.9445C05F@crm.mot.com>
Date: Tue, 12 Jun 2001 13:49:48 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Vyskubov <alexey.vyskubov@nokia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff allocation
In-Reply-To: <3B25F227.5A5EEBB4@crm.mot.com> <20010612135356.A31447@Hews1193nrc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Vyskubov wrote:
> 
> Why don't you use netfilter hooks? Write your hook for NF_IP_POST_ROUTING; it
> will receive sk_buff **pskb, so you can completely replace old skbuff with new.

Because, it doesn't seems to fit my needs.
The hardware header must present.

But I could have missed something looking at the kernel code.

Thanks a lot

-Manu
