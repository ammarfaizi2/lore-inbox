Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268700AbTCCSip>; Mon, 3 Mar 2003 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268706AbTCCSio>; Mon, 3 Mar 2003 13:38:44 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:44418 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268700AbTCCSin>; Mon, 3 Mar 2003 13:38:43 -0500
Date: Mon, 3 Mar 2003 19:49:06 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: re: 2.5-bk menuconfig format problem
Message-ID: <20030303184906.GF6946@louise.pinerecords.com>
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303175844.A29121@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [hch@infradead.org]
> 
> On Mon, Mar 03, 2003 at 03:15:34PM +0000, Andrew Walrond wrote:
> > Just done a pull and now the first entry of make menuconfig is:
> > 
> >   [*] Support for paging of anonymous memory
> > 
> > It shouldn't really be there, should it?
> 
> Why not?  Even if you never want to use a swapless kernel there's still
> plenty use for it.

Andrew probably means the problem is in _where_ the entry shows up in
menuconfig (and he's right).  I believe he didn't mean to question the
existence of the option.

-- 
Tomas Szepe <szepe@pinerecords.com>
