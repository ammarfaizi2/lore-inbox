Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFASA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFASA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFAR5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:57:09 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:17828 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVFAR40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:56:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UdfM3mr038F/JpfPb8Bv/kh7i/GcRb4igaWWhkz7zmvu9bWKur4dgs+9LCLRp/MnnL8lLMPKzoDBel9NRvlFu3oc2WehKaJR0tHjYYGlI9y95w+h+3cIXE4kclbYaQE9l9OqKzBveF57nxlWm3hWd8JUZZwlhuiUpV2WbCGyKrs=
Message-ID: <bd8e30a40506011056bb083a4@mail.gmail.com>
Date: Wed, 1 Jun 2005 10:56:22 -0700
From: "Paul G. Allen" <pgallen@gmail.com>
Reply-To: "Paul G. Allen" <pgallen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732321E@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AAD6DA242BC63C488511C611BD51F36732321E@MAILIT.keba.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/05, kus Kusche Klaus <kus@keba.com> wrote:
> 
> I would like to throw in my (and my employer's) point of view,
> which is the point of view of a potential user of RT linux,
> not the view of a kernel developer.
> 
> We are currently evaluating the suitability of Linux for
> industrial control systems.

As we are, but for a different embedded application (see below)

> 
> We strongly opt for having RT in the standard kernel,
> not as a separate patch.
> It will surely make a big difference for our final decision.

100% agreed.

> 
> From the engineer's point of view:
> 

I would have to agree with all your points here.

> 
> From the management's point of view:
> 

I would have to second all your points here as well.

As for our company, and the reason I'm now following RT Linux related
threads closely now (though I have missed a LOT over past months), we
currently have about 50K units fielded and that number is going to
grow significantly. We use VxWorks, which costs money. We don't need
all the features of VxWorks. We need a basic RTOS with no VM, a FFS
(currently the DOS FFS can lock the CPU for up to 2 sec. and we'd like
to significantly reduce this), will run on an embedded ARM7TDMI, and
will be supported in some manner (e.g. - a standard part of the
kernel). Something that is a "patch" will look bad to management and
make future updates, as was stated, a PITA.

To save on the licensing and development fees, I think we would have
no trouble developing the features we need (and turning around and
submitting them back to the community) IF RT Linux is at least close
to being ready for Prime Time with the features I mention above.

So, how stable is RT Linux (or any of the several flavors of real-time
Linux versions) and would it be suitable for an embedded system used
for communications? How long before it's part of the standard kernel
(even if it's just a compile-time option)?

PGA
