Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVILTH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVILTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVILTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:07:28 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47335 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932153AbVILTH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:07:27 -0400
Message-ID: <4325D1E8.9030302@adaptec.com>
Date: Mon, 12 Sep 2005 15:07:20 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org> <20050912160805.GC32395@parisc-linux.org>
In-Reply-To: <20050912160805.GC32395@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 19:07:26.0443 (UTC) FILETIME=[36BC83B0:01C5B7CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 12:08, Matthew Wilcox wrote:
> 
> I meant to reply to Luben's original, but I deleted it in disgust.
> As the person who converted SCSI from the old bottom-half completion
> processing first to a tasklet and then to a softirq, I'd like to refute
> at least part of this allegation.  I didn't do it in order to improve
> SCSI particularly, satisfy Splentec (who are they?), or prove a point.
> 
> I did it because I wanted to remove the old bottom-half mechanism and
> SCSI was one of the remaining users.  That required me to learn a bit
> about the SCSI stack and I got sucked in.  BTW, I believe at that time,
> James had alreeady taken over maintenance.  I'm not actually sure who
> the previous maintainer was -- was it Eric Biederman?
> 
> A colleague asked me to summarise the current dispute.  I said that
> Luben's point was that nobody else understood SCSI.  Everybody else's

No, my point is that SCSI Core "development" isn't following any
spec or document or any formally accepted spec.

And as more and more transports are coming aboard, you see more
and more "kludge" from SPI making everything fit around the
SCSI Core's legacy SPI as _opposed_ to _evolving_ SCSI Core.

> point was that Luben doesn't understand Linux kernel development.  Luben,
> I think you need to shut up, accept advice, stop trying to do everything
> in your own driver, and stop trying to have private conversations.

I've had private conversations _before_ I posted anything and those
were highly technical -- you know SAS stuff.

> Just discuss things on linux-scsi dispassionately.  There's no hidden

I have been, many times.

Absolutely no advice I've ever posted to linux-scsi has been accepted
ever, unless someone else implemented it.

Any advice I've ever posted have been SAM/SPC related.

> agenda to get you or your company.  But you are pissing people off,
> and very soon there *will* be because of your behaviour.

Personal threat on a public list?

	Luben

