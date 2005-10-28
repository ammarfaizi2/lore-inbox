Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJ1XgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJ1XgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVJ1XgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:36:16 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:62792 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750716AbVJ1XgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:36:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=WApfmxxYOc0DPkIJK81Hrbl35AvPD3pcm0NL2OM875ZkDBrogmCaNeSbvZ+NCBmb2TO6JRmPX9Tzt1GGJ5wT1+9Xk+zizfX6FTjJSQiFf4EYdw6MLc7G2K2Tvavqjzj2QZ7gbBe9Dk1hYj7uh8HYpHHV/N2i8tu6ZYkgDILsgdY=
Subject: Re: HEADS UP for QLA2100 users
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
In-Reply-To: <20051028230303.GI15018@plap.qlogic.org>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <1130186927.6831.23.camel@localhost.localdomain>
	 <20051024141646.6265c0da.akpm@osdl.org>
	 <20051027152637.GC7889@plap.qlogic.org>
	 <20051027190227.GA16211@infradead.org>
	 <20051027215313.GB7889@plap.qlogic.org>
	 <20051028225155.GA13958@infradead.org>
	 <20051028230303.GI15018@plap.qlogic.org>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 16:35:43 -0700
Message-Id: <1130542543.23729.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 16:03 -0700, Andrew Vasquez wrote:
> On Fri, 28 Oct 2005, Christoph Hellwig wrote:
> 
> > On Thu, Oct 27, 2005 at 02:53:13PM -0700, Andrew Vasquez wrote:
> > 
> > > I'm still in the process of ironing out the .bin distribution details
> > > locally, but perhaps once we migrate to firmware-loading exclusively
> > > via request_firmware(), the (small?) contigent of 2100 could use the
> > > EF variant I referenced above.
> > 
> > You know, I'm in favour of getting firmware images in the kernel image,
> > but what's the problem of simply downgrading the 2100 firmware until
> > we get rid of the builtin firmware for all qla2xxx variants?
> 
> I have no problems with submitting 1.17.38 EF for inclusion upstream.
> My only hope is that for the (other) 2100 user out there that use the
> latest 2100 firmware and are not experiencing problems, the downgrade
> does not break anything.
> 
> That's another reason I posed the following question:
> 
> > > Could I get another informal count of 2100 users who are still having
> > > problems with qla2xxx?
> 
> Perhaps I should also ask:
> 
> 	Who's running 2100 cards with the latest qla2xxx driver and
> 	are experiencing no problems?

Hmm.. I thought qla2xxx driver doesn't like qla2100. I had troubles
getting my qla2100 cards to work with qal2xxx (9 months ago) and
gave up and using only qla2200 and qla2300 card.

Is there a point in me going back and trying qla2100 ? (Ofcourse,
I need to locate those cards).

Thanks,
Badari

