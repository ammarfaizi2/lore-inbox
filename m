Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGYMQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGYMQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUGYMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 08:16:04 -0400
Received: from baikonur.stro.at ([213.239.196.228]:1694 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S262322AbUGYMQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 08:16:02 -0400
Date: Sun, 25 Jul 2004 14:15:57 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Christoph Hellwig <hch@infradead.org>, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch-kj] use list_for_each() in fs/jffs/intrep.c
Message-ID: <20040725121557.GA1756@stro.at>
References: <20040723155528.GQ1795@stro.at> <20040723161724.GA31884@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723161724.GA31884@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Christoph Hellwig wrote:

> On Fri, Jul 23, 2004 at 05:55:28PM +0200, maximilian attems wrote:
> > 
> > Use list_for_each() where applicable
> > - for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
> > + list_for_each(list, &ymf_devs) {
> > pure cosmetic change, defined as a preprocessor macro in:
> > include/linux/list.h
> > 
> > applies cleanly to 2.6.8-rc2
> > 
> > From: Domen Puncer <domen@coderock.org>
> > Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> 
> Please switch to list_for_each_entry while you're at it.

thx will look through the patches that needs that.
a++ maks

