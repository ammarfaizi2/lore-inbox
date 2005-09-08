Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVIHPhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVIHPhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVIHPhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:37:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932593AbVIHPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:37:00 -0400
Date: Thu, 8 Sep 2005 16:36:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add stricmp
Message-ID: <20050908153659.GA11780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43206F420200007800024455@emea1-mh.id2.novell.com> <20050908151754.GB11067@infradead.org> <432074B302000078000244A3@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432074B302000078000244A3@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:28:19PM +0200, Jan Beulich wrote:
> Then how am I supposed to do ASCII-only case-insensitive compares (i.e.
> reading config files)?

You're not supposed to read config files in the kernel, nevermind
case-insensitive ones.  If you want things case-insensitive please stay in
the DOS world, thanks.

> The intended user can be seen at
> http://forge.novell.com/modules/xfmod/project/?nlkd (and see also my
> previous reply to your earlier, similar complaint).

That's not a useful user.  It's a big mess that should stay away from the
kernel as far as possible.

