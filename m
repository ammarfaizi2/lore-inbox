Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUATTqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUATTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:46:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:29705 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265686AbUATTqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:46:19 -0500
Date: Tue, 20 Jan 2004 19:46:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: andersen@codepoet.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support 4 GB files with fat32
Message-ID: <20040120194610.A20253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	andersen@codepoet.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040120193854.GA12264@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120193854.GA12264@codepoet.org>; from andersen@codepoet.org on Tue, Jan 20, 2004 at 12:38:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:38:54PM -0700, Erik Andersen wrote:
> -int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, unsigned long *bytes)
> +int cont_prepare_write(struct page *page, unsigned offset, unsigned to, get_block_t *get_block, loff_t *bytes)

I don't think we should changes APIs that late in the 2.4 series.

