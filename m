Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVIHPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVIHPuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVIHPuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:50:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42983 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932622AbVIHPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:50:12 -0400
Date: Thu, 8 Sep 2005 16:50:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] re-export genapic on i386
Message-ID: <20050908155011.GA12359@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4320793602000078000244D9@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4320793602000078000244D9@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:47:34PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> A change not too long ago made i386's genapic symbol no longer be
> exported,
> and thus certain low-level functions no longer be usable. Since
> close-to-
> the-hardware code may still be modular, this rectifies the situation.

Again, what code would use it, why and why can't it use a proper accessor.
And a shitty thousands of lines out ot tree debugger ported from Novell's
legacy OS is not the answer, btw.

