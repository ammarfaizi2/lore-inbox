Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVI3WGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVI3WGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVI3WGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:06:19 -0400
Received: from magic.adaptec.com ([216.52.22.17]:31194 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030465AbVI3WGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:06:18 -0400
Message-ID: <433DB6BE.4020706@adaptec.com>
Date: Fri, 30 Sep 2005 18:05:50 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, willy@w.ods.org,
       Patrick Mansfield <patmans@us.ibm.com>, ltuikov@yahoo.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>	 <433D8542.1010601@adaptec.com> <1128113158.12267.29.camel@mulgrave>
In-Reply-To: <1128113158.12267.29.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 22:05:50.0453 (UTC) FILETIME=[1E425250:01C5C60B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 16:45, James Bottomley wrote:
> On Fri, 2005-09-30 at 14:34 -0400, Luben Tuikov wrote:
> 
>>James, Linus, can we have this driver in the kernel now, please?
> 
> 
> A while ago I told you that if you could show that the transport class
> abstraction could not support both the aic94xx and LSI SAS cards then we

I have, by example and by spec.  They both use two different
and distinct architectures.

Now _you_ have decided that this isn't the case, simply because
you want to prove your own idea.  (which breaks SAM layering)

I think I explained the similarity of the SAS Transport Layer
to *USB and SBP*.

As I said: everyone wants a pice of the SAS code.
You do too.

I'm sure you'll do whatever humanly possible to show
that _your_ idea can be applied: you can do this now:
just use a big if () { ... } else { ... } statement and
you're done.

Furthermore I do not see the reasons to umbrella both
"aic94xx and LSI cards" when they are _completely different_
in architecture: MPT and open transport (ala USB Storage and SBP).

> could look at doing SAS differently.  Since then you have asserted many
> times that a transport class could not work for the aic94xx (mostly by
> making inaccurate statements about what the transport class abstraction
> is) but have never actually provided any evidence for your assertion.

The code is here:
http://linux.adaptec.com/sas/

>>Now to things more pertinent, which I'm sure people are interested in:
>>
>>Jeff has been appointed to the role of integrating the SAS code
>>with the Linux SCSI _model_, with James Bottomley's "transport
>>attributes".
>>So you can expect more patches from him.
> 
> So very soon now, with proof by code, we shall have confirmation or
> negation of that assertion.  I'll wait quietly for this to happen, and I
> would suggest you do the same.

I just thought it was only fare to the rest of the community
to know how far the politics has escalated.

Everyone wants a piece of the SAS code.

	Luben

