Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268716AbTCCTMW>; Mon, 3 Mar 2003 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268727AbTCCTMW>; Mon, 3 Mar 2003 14:12:22 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:53634 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268716AbTCCTMV>; Mon, 3 Mar 2003 14:12:21 -0500
Date: Mon, 3 Mar 2003 20:22:45 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: re: 2.5-bk menuconfig format problem
Message-ID: <20030303192245.GH6946@louise.pinerecords.com>
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org> <20030303184906.GF6946@louise.pinerecords.com> <20030303185337.A30585@infradead.org> <20030303191908.GA3609@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303191908.GA3609@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [sam@ravnborg.org]
> 
> On Mon, Mar 03, 2003 at 06:53:37PM +0000, Christoph Hellwig wrote:
> > Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
> > on it's placements.  If people who actually do use if feel that it's placed
> > wrongly feel free to submit a patch to fix it.
> 
> The following patch moves it to the menu "Processor type & features"
> Right before HIMEM.

Please don't do this.  While HIMEM could still be perceived as a processor
(architecture) feature, SWAP certainly doesn't qualify.  We already have
enough misplaced options.

-- 
Tomas Szepe <szepe@pinerecords.com>
