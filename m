Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVIRKYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVIRKYI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVIRKYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:24:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57828 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750876AbVIRKYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:24:07 -0400
Date: Sun, 18 Sep 2005 11:23:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Christoph Hellwig <hch@infradead.org>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050918102357.GA22210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <432B1F84.3000902@namesys.com> <20050917092247.GA13992@infradead.org> <200509171356.14497.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509171356.14497.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 01:56:14PM +0300, Denis Vlasenko wrote:
> At least reiser4 is smaller. IIRC xfs is older than reiser4 and had more time
> to optimize code size, but:
> 
> reiser4        2557872 bytes
> xfs            3306782 bytes

and romfs is smaller than ext2, damn.  Should we remove all filesystems but
romfs now?


and yeah, if you didn't get the hint compare the feature sets.

