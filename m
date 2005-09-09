Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVIITAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVIITAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVIITAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:00:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5539 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932576AbVIITAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:00:10 -0400
Date: Fri, 9 Sep 2005 20:00:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
Message-ID: <20050909190007.GA12109@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200509091817.39726.zam@namesys.com> <4321C806.60404@namesys.com> <20050909185740.GA11923@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909185740.GA11923@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 07:57:40PM +0100, Christoph Hellwig wrote:
> A very annoying small thing that comes to mind is the usage of
> reiser4_internal.  Please remove it, all but exported symbol are
> module-private.

Oh, one other things that's totally annoying and makes reading the
code a pain are the line-length and comment style.  Please wrap
lines after 80 chars and use normal

/* foobar, blagg */

or 

/*
 * fvsfafsfasdrfasddddddddddddddddddddd
 * fdsfsfdsfsdf
 * sdfsdfs
 */

comments, thanks

