Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUIVT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUIVT2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIVT2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:28:18 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18316 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266721AbUIVT2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:28:16 -0400
Subject: Re: The new PCI fixup code ate my IDE controller
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922183905.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922174929.GP16153@parcelfarce.linux.theplanet.co.uk>
	 <1095877177.17821.1535.camel@hades.cambridge.redhat.com>
	 <20040922183905.GQ16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1095881294.17821.1553.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 22 Sep 2004 20:28:14 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 19:39 +0100, Matthew Wilcox wrote:
> On Wed, Sep 22, 2004 at 07:19:37PM +0100, David Woodhouse wrote:
> > Hmm. We already have two passes through the fixup stuff. Add a third?
> > But sorting PCI_ANY_ID to go last seems like a reasonable first stab at
> > an answer, if that's sufficient for your purposes.
> 
> I don't think we need to go that far.  Something like the following
> should work ... (untested, uncompiled, whitespace-damaged)

Looks good to me.

-- 
dwmw2

