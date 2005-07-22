Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVGVOl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVGVOl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVGVOl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:41:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262096AbVGVOl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:41:56 -0400
Date: Fri, 22 Jul 2005 15:41:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] type safe list
Message-ID: <20050722144153.GA17220@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <42E0FBA0.6050502@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E0FBA0.6050502@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 05:58:56PM +0400, Vladimir V. Saveliev wrote:
> Hello
> 
> This is implementaion of circular doubly linked parametrized list.
> It is similar to the list implementation in include/linux/list.h
> but it also provides type safety which allows to detect some of list 
> manipulating
> mistakes as soon as they happen.

This looks like an ugly solution in search of a problem.  Just use
normal list.h list and get rid of this mess.

