Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUFGOAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUFGOAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUFGOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:00:18 -0400
Received: from [213.146.154.40] ([213.146.154.40]:35024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264652AbUFGOAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:00:12 -0400
Date: Mon, 7 Jun 2004 15:00:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid() bug in 2.6?]
Message-ID: <20040607140009.GA21480@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Russell Leighton <russ@elegant-software.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com> <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com> <40C3AD9E.9070909@elegant-software.com> <20040607121300.GB9835@devserv.devel.redhat.com> <6uu0xn5vio.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uu0xn5vio.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 02:48:31PM +0100, Sean Neakums wrote:
> > for example ia64 doesn't have it.
> 
> Then what is the sys_clone2 implementation in arch/is64/kernel/entry.S for?

It's clone with a slightly different calling convention.

