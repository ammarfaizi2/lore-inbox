Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWIAAp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWIAAp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWIAAp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:45:28 -0400
Received: from xenotime.net ([66.160.160.81]:34025 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932281AbWIAAp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:45:27 -0400
Date: Thu, 31 Aug 2006 17:48:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block
 layer [try #2]
Message-Id: <20060831174852.18efec7e.rdunlap@xenotime.net>
In-Reply-To: <1157069717.2347.13.camel@shinybook.infradead.org>
References: <20060825142753.GK10659@infradead.org>
	<20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	<20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	<10117.1156522985@warthog.cambridge.redhat.com>
	<15945.1156854198@warthog.cambridge.redhat.com>
	<20060829122501.GA7814@infradead.org>
	<44F44639.90103@s5r6.in-berlin.de>
	<44F44B8D.4010700@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0608300311430.6761@scrub.home>
	<44F5DA00.8050909@s5r6.in-berlin.de>
	<20060830214356.GO18276@stusta.de>
	<Pine.LNX.4.64.0608310039440.6761@scrub.home>
	<1157069717.2347.13.camel@shinybook.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 17:15:17 -0700 David Woodhouse wrote:

> On Thu, 2006-08-31 at 00:41 +0200, Roman Zippel wrote:
> > > USB_STORAGE switched from a depending on SCSI to select'ing SCSI three 
> > > years ago, and ATA in 2.6.19 will also select SCSI for a good reason:
> > 
> > It was already silly three years ago.
> 
> I agree.
> 
> > > When doing anything kconfig related, you must always remember that the 
> > > vast majority of kconfig users are not kernel hackers.
> > 
> > What does that mean, that only kernel hackers can read? 
> 
> No, it means that we're pandering to Aunt Tillie.

But David, you edit .config anyway, so who is "make *config" for?
Not that I want enable Tillie very much..

---
~Randy
