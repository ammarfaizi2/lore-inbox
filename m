Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUKIM55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUKIM55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKIM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:57:57 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:12299 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261245AbUKIM5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:57:54 -0500
Date: Tue, 9 Nov 2004 12:57:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 17/20] FRV: Better mmap support in uClinux
Message-ID: <20041109125747.GB4867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20040401020550.GG3150@beast> <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* list of shareable VMAs */
> +LIST_HEAD(nommu_vma_list);
> +DECLARE_RWSEM(nommu_vma_sem);

As I told you this absolutely should be static.

