Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTHANOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270760AbTHANOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:14:50 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:35847 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270759AbTHANOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:14:49 -0400
Date: Fri, 1 Aug 2003 14:14:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Calum Mackay <calum.mackay@cdmnet.org>
Cc: marcelo@conectiva.com.br, calum.mackay@sun.com, mitch.dsouza@sun.com,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4: export the symbol "mmu_cr4_features" for XFree86 DRM kernel drivers
Message-ID: <20030801141445.A8186@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Calum Mackay <calum.mackay@cdmnet.org>, marcelo@conectiva.com.br,
	calum.mackay@sun.com, mitch.dsouza@sun.com,
	linux-kernel@vger.kernel.org
References: <3F2A62A2.mailx3G211O2B4@cdmnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F2A62A2.mailx3G211O2B4@cdmnet.org>; from calum.mackay@cdmnet.org on Fri, Aug 01, 2003 at 01:52:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:52:50PM +0100, Calum Mackay wrote:
> I'd like to request comments on the appended; proposed patch for 2.4 to
> export the symbol "mmu_cr4_features".
> 
> This is needed by the XFree86 DRM kernel drivers, since Christoph's
> backport of vmap() in 2.4.22-pre7. [some] DRM kernel drivers (e.g. radeon]
> refuse to load without this fix, from 2.4.22-pre7 onwards.

Can you explain why they need it and why they magically need it
because of vmap() ?

