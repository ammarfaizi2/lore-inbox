Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVAMVOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVAMVOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVAMVHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:07:40 -0500
Received: from [213.146.154.40] ([213.146.154.40]:62361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261689AbVAMVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:05:03 -0500
Date: Thu, 13 Jan 2005 21:05:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christian Borntraeger <cborntra@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reintroduce EXPORT_SYMBOL(task_nice) for binfmt_elf32
Message-ID: <20050113210501.GA29232@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Borntraeger <cborntra@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>
References: <200501132042.31215.cborntra@de.ibm.com> <20050113194807.GA28010@infradead.org> <200501132202.25048.cborntra@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501132202.25048.cborntra@de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:02:24PM +0100, Christian Borntraeger wrote:
> Agreed. Better?

Looks fine.

Although a little comment explaining what it's exported for might be
nice ;-)  So people can't complain if it's unexported if binfmt_elf
doesn't need it anymore one day.

