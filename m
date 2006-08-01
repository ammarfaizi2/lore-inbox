Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWHAQ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWHAQ0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWHAQ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:26:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34805 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750815AbWHAQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:26:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=g+jgtPvFlq5mKKXmG62Ov8e1bB2JTtoZbgXGkkGYTZSoVi3ZHUvGmwZxZ6P7MI2ekOa8gCA3LSqGqTEyb3e6+Fw4rZUh+X7uKkzxgFVDMFe3y3yFsdHsSljA53JiStqrTmV6ZrT1pFPIAuGwLnMOwcSF3gUQ9xaVWCJZl8upZRo=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: do { } while (0) question
Date: Tue, 1 Aug 2006 12:26:26 -0400
User-Agent: KMail/1.9.1
Cc: Jonathan Matthews-Levine <matthewslevine@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com> <404c96810608010145r4c109fdet9eadba7090321048@mail.gmail.com> <20060801085343.GC9589@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060801085343.GC9589@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011226.27699.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 04:53, Heiko Carstens wrote:
> On Tue, Aug 01, 2006 at 09:45:26AM +0100, Jonathan Matthews-Levine wrote:
> > On 01/08/06, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > >---
> > >Always use do {} while (0).  Failing to do so can cause subtle compile
> > >failures or bugs.
> > >---
> > >
> > >I'm really wondering what these subtle compile failures or bugs are.
> > >Could you please explain?
> > 
> > http://kernelnewbies.org/FAQ/DoWhile0
> 
> My question was referring to empty do { } while (0)'s... that's something
> the FAQ is not dealing with :)

For readers and writers familiar with the idiom, it is easier to use
it for all macros intended to act like statements. Its presence will
actually be less suprising than its absence, even in situations when
it doesn't actually change anything.

Andrew Wade
