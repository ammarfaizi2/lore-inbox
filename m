Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVLPQqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVLPQqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLPQqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:46:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53966 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750742AbVLPQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:46:45 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051216141002.2b54e87d.diegocg@gmail.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Dec 2005 17:46:29 +0100
Message-Id: <1134751589.2992.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 14:10 +0100, Diego Calleja wrote:
> El Thu, 15 Dec 2005 14:00:13 -0800,
> Andrew Morton <akpm@osdl.org> escribió:
> 
> 
> > Supporting 8k stacks is a small amount of code and nobody has seen a need
> > to make changes in there for quite a long time.  So there's little cost to
> > keeping the existing code.
> > 
> > And the existing code is useful:
> 
> Maybe this slighty different approach is better? 
> 
> 
> 
> Signed-off-by: Diego Calleja <diegocg@gmail.com>


I like this one; it makes the default 4K while leaving the 8K option for
those who really want it...

Acked-by: Arjan van de Ven <arjan@infradead.org>

