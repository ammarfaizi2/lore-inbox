Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWIAAPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWIAAPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWIAAPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:15:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964826AbWIAAPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:15:45 -0400
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block
	layer [try #2]
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608310039440.6761@scrub.home>
References: <20060825142753.GK10659@infradead.org>
	 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	 <10117.1156522985@warthog.cambridge.redhat.com>
	 <15945.1156854198@warthog.cambridge.redhat.com>
	 <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de>
	 <44F44B8D.4010700@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0608300311430.6761@scrub.home>
	 <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de>
	 <Pine.LNX.4.64.0608310039440.6761@scrub.home>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 17:15:17 -0700
Message-Id: <1157069717.2347.13.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 00:41 +0200, Roman Zippel wrote:
> > USB_STORAGE switched from a depending on SCSI to select'ing SCSI three 
> > years ago, and ATA in 2.6.19 will also select SCSI for a good reason:
> 
> It was already silly three years ago.

I agree.

> > When doing anything kconfig related, you must always remember that the 
> > vast majority of kconfig users are not kernel hackers.
> 
> What does that mean, that only kernel hackers can read? 

No, it means that we're pandering to Aunt Tillie.

-- 
dwmw2

