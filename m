Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJTO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJTO4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUJTO4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:56:23 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:17288 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266683AbUJTOy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:54:58 -0400
Subject: Re: [PATCH] Remove union u from linux/fs.h
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20041020131015.GB20287@infradead.org>
References: <2c59f00304102002135ca68dd0@mail.gmail.com>
	 <20041020131015.GB20287@infradead.org>
Content-Type: text/plain
Message-Id: <1098284026.3872.121.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 20 Oct 2004 15:53:46 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 14:10 +0100, Christoph Hellwig wrote:
> > This patch does that along with the changes in other parts of the
> > kernel that references the union. Its compile-tested and applies
> > cleanly to 2.6.9 vanilla.
> 
> I don't think we shoould do such purely cosmetic changes that break backwards
> compatibility during stable series.

I don't think he meant to apply it to 2.6.9.1. 2.6.10.x is an entirely
new stable series, and 2.6.10-rcX are the development series leading up
to it, surely?

-- 
dwmw2


