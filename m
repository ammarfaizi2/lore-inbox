Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWIAB1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIAB1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWIAB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:27:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2759 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750818AbWIAB1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:27:31 -0400
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block
	layer [try #2]
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060831174852.18efec7e.rdunlap@xenotime.net>
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
	 <1157069717.2347.13.camel@shinybook.infradead.org>
	 <20060831174852.18efec7e.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 18:27:27 -0700
Message-Id: <1157074048.2347.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 17:48 -0700, Randy.Dunlap wrote:
> But David, you edit .config anyway, so who is "make *config" for?
> Not that I want enable Tillie very much.. 

I edit .config but still have to use 'make oldconfig' afterwards. And it
screws me over because of all this 'select' nonsense. This used to
work...
	sed -i /^CONFIG_SCSI=/d .config 
	yes n | make oldconfig

So "make *config" certainly isn't optimised for me, although of course I
do have to use it. It seems to be increasingly optimised for Aunt
Tillie.

-- 
dwmw2

