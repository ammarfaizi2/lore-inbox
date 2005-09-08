Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVIHPhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVIHPhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVIHPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:37:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932599AbVIHPhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:37:54 -0400
Date: Thu, 8 Sep 2005 16:37:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] abstraction of i386 machine check handlers
Message-ID: <20050908153753.GB11780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <432075E502000078000244AE@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432075E502000078000244AE@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:33:25PM +0200, Jan Beulich wrote:
> -static fastcall void k7_machine_check(struct pt_regs * regs, long
> error_code)
> +static MCE_HANDLER(k7)

such obsfucation is a big no-way.

