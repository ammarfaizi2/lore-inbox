Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUHKX1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUHKX1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHKXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:25:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:51379 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268347AbUHKXVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:21:43 -0400
Subject: Re: ipw2100 wireless driver
From: David Woodhouse <postmaster@infradead.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040811231124.GC14073@louise.pinerecords.com>
References: <20040811163333.GE10100@louise.pinerecords.com>
	 <20040811175105.A30188@infradead.org>
	 <20040811170208.GG10100@louise.pinerecords.com>
	 <20040811181142.A30309@infradead.org>
	 <20040811172222.GI10100@louise.pinerecords.com>
	 <20040811184148.A30660@infradead.org>
	 <20040811175109.GJ10100@louise.pinerecords.com>
	 <1092264200.1438.4347.camel@imladris.demon.co.uk>
	 <20040811225612.GB14073@louise.pinerecords.com>
	 <1092265608.1438.4364.camel@imladris.demon.co.uk>
	 <20040811231124.GC14073@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1092266501.1438.4375.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 12 Aug 2004 00:21:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 01:11 +0200, Tomas Szepe wrote:
> On Aug-12 2004, Thu, 00:06 +0100
> David Woodhouse <postmaster@infradead.org> wrote:
> 
> > On Thu, 2004-08-12 at 00:56 +0200, Tomas Szepe wrote:
> > > Ok, thanks for the warning.  Is there any reason why you should
> > > be trying to look up postmaster@ from the sender domain upon
> > > RCPT TO?
> > 
> > Part of standard verification of sender addresses. You're being offered
> > an email.... if you can't send a bounce to the address it claims to come
> > from, or if you can't send a mail to postmaster at the same domain, then
> > the chances that the mail you're being offered is a fake are high enough
> > to warrant rejecting it.
> 
> Ok, I see, but wouldn't an "and" where you write "or" make more sense? :)

Don't think so. I reject the mail _either_ if I can't send a bounce to
the user it claims to come from, _or_ if I can't send mail to the
postmaster at that domain. Either failure is sufficient to cause a
rejection.

I don't accept mail from an invalid user just because I can contact
postmaster, and I don't accept any mail from a domain for which I can't
contact postmaster (except for mail addressed to postmaster@ one of my
domains, which is more permissive in order to assist debugging/reporting
problems).

> Anyway, I screwed up in the aliases vs. virtusertable department again.

I saw it was fixed, and I wiped my callout cache so you should be able
to send mail to users @infradead.org other than postmaster again.

-- 
dwmw2


