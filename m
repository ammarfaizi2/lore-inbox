Return-Path: <linux-kernel-owner+w=401wt.eu-S1752810AbWLOQQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbWLOQQO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbWLOQQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:16:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:10946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbWLOQQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:16:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hT/yDUmih7mKuxmcs12R4y1s7JwRIXqa2lDJjvb4XXRL4DSuYqkZ1iK7U88Jql5efB48ARbAJcuEB1xb4dHLW/rYHAiElkFcj3/KPDLg9nsfMVDAzDXWpX9sGWfsfgSiYYfM0lZebuANuX7reLDwwUEzO3bT9OsIPWUwSrjIuHw=
Message-ID: <7b69d1470612150816w1684f6cbw1c3fa1779ed282c3@mail.gmail.com>
Date: Fri, 15 Dec 2006 10:16:11 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH/v2] CodingStyle updates
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061215150717.GA2345@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
	 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de>
	 <20061215142206.GC2053@elf.ucw.cz>
	 <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
	 <20061215150717.GA2345@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2006-12-15 08:52:22, Scott Preece wrote
> >
> > I think the mistake illuminates why parentheses should be the rule. If
> > you're thinking about using spacing to convey grouping, use
> > parentheses instead...
>
> Not in simple cases.
>
>         3*i + 2*j should be writen like that. Not like
>         (3 * i) + (2 * j)
---

Actually, my preference would be to use the parentheses AND drop the
spaces:   (3*i)+(2*j) . But, existing kernel code seems to prefer just
using spaces and adding parentheses when it gets complicated. Note
that the mistake in your example was in a relatively simple
expression.

I think the unary operator case is a little different - it's not so
much to make precedence clear as just to help the reader chunk the
pieces of the string more naturally (at least, it's more natural to
anyone who's ever done anything object-oriented). I agree that your
spacing example, above, also helps that way, but it seems better to do
it in a way that's meaningful o the compiler as well as to the reader.

scott
