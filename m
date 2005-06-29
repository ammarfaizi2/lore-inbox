Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVF2OYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVF2OYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVF2OYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:24:18 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:34207 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262589AbVF2OYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:24:05 -0400
Date: Wed, 29 Jun 2005 16:23:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: rostedt@goodmis.org, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Message-ID: <20050629142317.GB2130@wohnheim.fh-wedel.de>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain> <200506291714.32990.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506291714.32990.vda@ilport.com.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 June 2005 17:14:32 +0300, Denis Vlasenko wrote:
> 
> This is why I always use _irqsave. Less error prone.
> And locking is a very easy to get 'slightly' wrong, thus
> I trade 0.1% of performance for code simplicity.

But sometimes you get lucky and trade 100ms latency for code
simplicity.  Of course, the audio people don't mind anymore, now that
we have all sorts of realtime patches.  Everyone's happy!

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
