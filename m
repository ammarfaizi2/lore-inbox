Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWCGQko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWCGQko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCGQko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:40:44 -0500
Received: from kanga.kvack.org ([66.96.29.28]:40927 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750867AbWCGQko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:40:44 -0500
Date: Tue, 7 Mar 2006 11:35:31 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307163531.GB5410@kvack.org>
References: <20060307004237.GT20768@kvack.org> <20060306.165129.62204114.davem@davemloft.net> <20060307013915.GU20768@kvack.org> <20060306.190633.08168501.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.190633.08168501.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 07:06:33PM -0800, David S. Miller wrote:
> You've just reinvented fbufs, and they have their own known set of
> issues.

> Please read chapter 5 of Networking Algorithmics or ask someone to
> paraphrase the content for you.  It really covers this completely, and
> once you read it you will be able to avoid reinenting the wheel and
> falling under the false notion of having invented something :-)

Nothing in software is particularly unique given the same set of 
requirements.  Unfortunately, none of the local book stores have a copy 
of Networking Algorithmics in stock, so it will be a few days before it 
arrives.  What problems does this approach have?  Aside from the fact that 
it's useless unless implemented on top of AIO type semantics, it looks 
like a good way to improve performance.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
