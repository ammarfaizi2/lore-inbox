Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTKLPBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKLPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:01:37 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:49339 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262071AbTKLPBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:01:34 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
References: <Pine.LNX.4.44.0311100851190.16790-100000@logos.cnet>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Nov 2003 15:48:34 +0100
In-Reply-To: <Pine.LNX.4.44.0311100851190.16790-100000@logos.cnet>
Message-ID: <m3r80d8wxp.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> > After 2.4.23-rcX becomes final 2.4.23, the 2.4.24-preX would become
> > 2.4.24-rc1 and would be a base for 2.4.25-pre1.
> 
> I really dont understand this "be a base for 2.4.25-pre1".

Is the same way as 2.4.24 will be - i.e. from a -pre kernel point of
view, last -rc = final.

> I guess what you mean is you want a separate 2.4.24-pre tree accepting 
> "-pre" patches while 2.4.23-rc is "in stage" accepting critical bugfixes 
> only.

Yes.
The advantage is simple - the maintainer has to evaluate the same set
of patches once (no increase in work here) and the only additional thing
(s)he must do is deciding which (-pre and -rc or only -rc) kernels does
it go in.
-- 
Krzysztof Halasa, B*FH
