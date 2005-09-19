Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVISJYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVISJYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVISJYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:24:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58598 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932400AbVISJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:24:45 -0400
Date: Mon, 19 Sep 2005 10:24:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050919092444.GA17501@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <432AFB44.9060707@namesys.com> <20050918110658.GA22744@infradead.org> <432E8282.6060905@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E8282.6060905@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:18:58PM +0400, Vladimir V. Saveliev wrote:
> Hello
> 
> Christoph Hellwig wrote:
> > I threw in your new codedrop into a compilation and the byte-order
> > mess is _still_ now sorted out.  
> 
> Did compiling notice this mess?
> We used to compile with C=1. Should we compile somehow else before sending code out?

Log is at:

	http://verein.lst.de/~hch/reiser4.log

C=1 with whatever sparse version I had, nevermind what version it is code
is not good, just use __le types instead of structs and casting exercises,
makes the code simpler and easier to verify.

