Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVACLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVACLv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 06:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVACLv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 06:51:26 -0500
Received: from [213.146.154.40] ([213.146.154.40]:20198 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261428AbVACLvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 06:51:22 -0500
Date: Mon, 3 Jan 2005 11:51:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103115120.GB18408@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> remove-the-bkl-by-turning-it-into-a-semaphore.patch
>   remove the BKL by turning it into a semaphore

This _smp_processor_id() mess is horribly ugly.  Do you really need that
debug check?

