Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269668AbUJMK2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269668AbUJMK2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUJMK2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 06:28:31 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:12037 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269668AbUJMK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 06:28:30 -0400
Date: Wed, 13 Oct 2004 11:28:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xfs problems in 2.6.9-rc4 ?
Message-ID: <20041013102826.GA30851@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Danny ter Haar <dth@ncc1701.cistron.net>,
	linux-kernel@vger.kernel.org
References: <ckit8i$np4$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ckit8i$np4$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 09:41:38AM +0000, Danny ter Haar wrote:
> On our usenet storage server (diablo setup) we are running
> 2.6.9-rc4 and we see a *lot* of this in dmesg:
> 
> xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
> xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
> printk: 2899 messages suppressed.

Try to increase /proc/sys/vm/min_free_kbytes

