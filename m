Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVB0Wo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVB0Wo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVB0Wo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:44:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3802 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261500AbVB0Wo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:44:57 -0500
Date: Sun, 27 Feb 2005 22:44:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050227224454.GA2168@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
	linux-kernel@vger.kernel.org
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <1109318525.6290.32.camel@laptopd505.fenrus.org> <20050225002804.4905b649.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225002804.4905b649.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 12:28:04AM -0800, Andrew Morton wrote:
> > for _set_ time of day? I really can't imagine anyone messing with that.
> > _get_... sure. but set???
> 
> Sure.  But there must have been a reason to export it in the first place.

NO.  Speaking from experience there's tons of totally pointless exports.

> I don't see much point in playing these games.  Deprecate it, pull it out
> next year, done.

Sorry, but without a development tree we don't want to play these deprecation
forever games.  If you want a longer warning period open 2.7 now that we
can work ahead there and leave 2.6 alone.  But restricting all kinds of
totally sane things from going in just doesn't work out.

