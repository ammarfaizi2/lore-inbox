Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268352AbUHKXw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268352AbUHKXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHKXpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:45:44 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32941 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268326AbUHKXGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:06:50 -0400
Subject: Re: ipw2100 wireless driver
From: David Woodhouse <postmaster@infradead.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040811225612.GB14073@louise.pinerecords.com>
References: <411A478E.1080101@linux.intel.com>
	 <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
	 <20040811163333.GE10100@louise.pinerecords.com>
	 <20040811175105.A30188@infradead.org>
	 <20040811170208.GG10100@louise.pinerecords.com>
	 <20040811181142.A30309@infradead.org>
	 <20040811172222.GI10100@louise.pinerecords.com>
	 <20040811184148.A30660@infradead.org>
	 <20040811175109.GJ10100@louise.pinerecords.com>
	 <1092264200.1438.4347.camel@imladris.demon.co.uk>
	 <20040811225612.GB14073@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1092265608.1438.4364.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 12 Aug 2004 00:06:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 00:56 +0200, Tomas Szepe wrote:
> Ok, thanks for the warning.  Is there any reason why you should
> be trying to look up postmaster@ from the sender domain upon
> RCPT TO?

Part of standard verification of sender addresses. You're being offered
an email.... if you can't send a bounce to the address it claims to come
from, or if you can't send a mail to postmaster at the same domain, then
the chances that the mail you're being offered is a fake are high enough
to warrant rejecting it.

Results are cached for a period of time -- the _first_ rejection should
have been more explicit than 'result of earlier verification reused' --
it should have actually given you the results of trying to send that
mail to postmaster@pinerecords.com:

	rcpt to:<postmaster@pinerecords.com>
	553 5.3.0 <postmaster@pinerecords.com>... No such user

-- 
dwmw2


