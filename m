Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUFWBeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUFWBeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUFWBeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:34:22 -0400
Received: from web51805.mail.yahoo.com ([206.190.38.236]:53395 "HELO
	web51805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264058AbUFWBeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:34:20 -0400
Message-ID: <20040623013419.18165.qmail@web51805.mail.yahoo.com>
Date: Tue, 22 Jun 2004 18:34:19 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: slow performance w/patch-2.6.7-mjb1
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <103650000.1087949393@flay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin et al,

So I configed with your patch just the basics and get
similar times that I do with 2.6.7 virigin and 2.4.21.
 However, as soon as I enable 4G split, the rt
increases by ~35s (out of 1m45s compared to 1m10s). 
Do you know if this is in line w/expectations?  Is
there anyway to reduce this?

Thank you for your time.
Phy

--- "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> > To the mbligh, maintainer of mjb patch sets:
> > 
> > I am trying to track down why I am seeing 2x in
> run
> > time with patch-2.6.7-mjb1.  I would like to get
> the
> > 4g/4g patch, hence the use of this patch set,
> however,
> > something within this patch has more than doubled
> the
> > run time for a test executable I have so I would
> like
> > to see what component might be the cause.  Is
> there a
> > list of the various patches that went into this
> patch
> > set and if so, are the patches in a broken out
> format?
> 
> Yeah, though I'd start with "time foo" and if it's
> system time,
> do a kernel profile. Let me know what it is, or give
> me a testcase ...
> This is compared to 2.6.7 virgin? or -current?
> current code has some
> wierd timer problems in mainline ... make sure to
> compare it to virgin.
> 
> Broken out patches are here under the patches/
> subdir if you're desperate ;-)
> eg:
>
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.7/2.6.7-mjb1
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
