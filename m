Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVFKPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVFKPlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFKPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:41:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28545 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261432AbVFKPlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:41:14 -0400
Date: Sat, 11 Jun 2005 16:41:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611154107.GA32149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050611074327.GA27785@kroah.com> <20050611102133.GA3770@stusta.de> <20050611143904.GA30612@suse.de> <20050611153656.GB3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611153656.GB3770@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 05:36:56PM +0200, Adrian Bunk wrote:
> Yes, there are many places where 2.4 and 2.6 are not source compatible 
> for good reasons. But if the effort for maintaining compatibility 
> between 2.4 and 2.6 in one area is as easy as keeping a header file with 
> some dummy funtions it's worth considering.

The devfs calls for 2.4 and 2.6 are totally incompatible.  And there's
a trivial way to support both 2.4 and 2.6 in this area:  don't support
devfs at all, it always was marked either experimental or deprecated
anyway.

