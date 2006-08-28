Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWH1Sny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWH1Sny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWH1Sny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:43:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751330AbWH1Snx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:43:53 -0400
Subject: Re: Linux v2.6.18-rc5
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060828114017.0c8d29c7.akpm@osdl.org>
References: <200608280554_MC3-1-C993-607@compuserve.com>
	 <20060828114017.0c8d29c7.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 20:43:46 +0200
Message-Id: <1156790626.3034.234.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 11:40 -0700, Andrew Morton wrote:
> On Mon, 28 Aug 2006 05:50:07 -0400
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > > From: Chuck Ebbert <76306.1226@compuserve.com>
> > > Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
> > 
> > Also happens on 2.6.16.28 and 2.6.17.11, so not a regression.
> 
> Well it's not a post-2.6.17 regression.  But it's something which quite a few
> people have been reporting in recent months.  I don't _think_ it's associated
> with any consistent runtime failures, but otoh I don't think we know what
> caused it.

in itself this can just happen (bios issue, but if the bars are unused
no big deal)... the kernel has gotten more verbose afaik though.

It CAN cause real issues so I'm not saying there's no problem or no
regression, it's just that the printk alone isn't serious.


