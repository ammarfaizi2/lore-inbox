Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVJENdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVJENdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVJENdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:33:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53159 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965168AbVJENdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:33:06 -0400
Subject: Re: [PATCH] Keys: Export user-defined keyring operations
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       Michael C Thompson <mcthomps@us.ibm.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128510159.2920.15.camel@laptopd505.fenrus.org>
References: <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com>
	 <28129.1128509939@warthog.cambridge.redhat.com>
	 <1128510159.2920.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Oct 2005 14:32:58 +0100
Message-Id: <1128519178.3116.16.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 13:02 +0200, Arjan van de Ven wrote:
> since this is new unique-to-linux functionality, could you please
> consider making the exports _GPL please?

What's the point? There can be no difference between the meaning of
EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() anyway.

§6 of the GPL says "You may not impose any further restrictions on the
recipients' exercise of the rights granted herein."

If there was really a meaningful difference between EXPORT_SYMBOL_GPL()
and EXPORT_SYMBOL(), then the GPL _itself_ would forbid the use of
EXPORT_SYMBOL_GPL() within the kernel, because that would impose
additional restrictions.

We should abolish the meaningless distinction between the two, because
it only encourages people to believe that EXPORT_SYMBOL() can be used
for non-GPL code. Either use EXPORT_SYMBOL() for everything, or switch
to EXPORT_SYMBOL_GPL() for everything. It doesn't really matter.

-- 
dwmw2

