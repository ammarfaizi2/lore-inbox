Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVAGJ2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVAGJ2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVAGJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:28:38 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:16783 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261328AbVAGJ2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:28:35 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: No swap can be dangerous (was Re: swap on RAID (was Re: swp - Re: ext3 journal on software raid))
Date: Fri, 7 Jan 2005 09:28:13 +0000
User-Agent: KMail/1.7.2
Cc: "Guy" <bugzilla@watkins-home.com>, "'Mike Hardy'" <mhardy@h3c.com>,
       "'Jesper Juhl'" <juhl-lkml@dif.dk>, linux-raid@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
References: <200501062316.j06NFP900855@www.watkins-home.com>
In-Reply-To: <200501062316.j06NFP900855@www.watkins-home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501070928.13307.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 23:15, Guy wrote:
> If I MUST/SHOULD have swap space....
> Maybe I will create a RAM disk and use it for swap!  :)  :)  :)

Well, indeed, I had the same thought. As long as you could guarantee that the 
ram was of the highmem/non-dmaable type...

But we're getting ahead of ourselves. I think we need an authoritive answer to 
the original premise. Perhaps Alan (cc-ed) might spare us a moment?

Did I dream this up, or is it correct?

"I think the gist was this: the kernel can sometimes needs to move bits of 
memory in order to free up dma-able ram, or lowmem. If I recall correctly, 
the kernel can only do this move via swap, even if there is stacks of free 
(non-dmaable or highmem) memory."

Andrew
