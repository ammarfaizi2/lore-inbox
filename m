Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWASFVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWASFVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWASFVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:21:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161019AbWASFVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:21:53 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 16:21:59 +1100
Message-Id: <1137648119.30084.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 16:52 -0800, akpm@osdl.org wrote:
> -                       memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
> +                       memcpy(&current->saved_sigmask, &sigsaved,
> +                                       sizeof(sigsaved));

I still object to this.

You justified it on the basis that some people have editors which will
wrap the original version onto a second line and make it look ugly...
yet your 'fix' is to wrap it onto a second line and make it look ugly
for _all_ of us, not just for those using crap editors. I really don't
see the overall benefit.

-- 
dwmw2

