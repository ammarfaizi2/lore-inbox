Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937753AbWLFWfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937753AbWLFWfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937750AbWLFWfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:35:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12857 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937746AbWLFWfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:35:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mtEFoURAo3cYxflKbB9FKRlrL0UGqZLpICDGgDOMR1D17dwuxMwT/t2uQNE7CBwr4cpXioHG5aZiIUp/VJU/csDPoZBouKbfALcJNiXuYNlxCBJpICUB4hRorTlyBYHHPmyp5uAfGzrKRMeVLc/9TqLIjLDJyiW7tcj/w1ml9Yo=
Message-ID: <a36005b50612061434t6e64c4bfn8f9c53e3bdea19b4@mail.gmail.com>
Date: Wed, 6 Dec 2006 14:34:59 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux should define ENOTSUP
Cc: "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <457731E7.6050000@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206135134.GJ3927@implementation.labri.fr>
	 <1165415115.3233.449.camel@laptopd505.fenrus.org>
	 <20061206143159.GP3927@implementation.labri.fr>
	 <4576DF04.4000900@zytor.com>
	 <a36005b50612061210q407ea90ew4a32328e65145bbf@mail.gmail.com>
	 <457731E7.6050000@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, H. Peter Anvin <hpa@zytor.com> wrote:
> I'm quite aware of that, but I still think Sun has more resources to get
> their particular viewpoint through the committee -- it's just a matter
> of resources at hand.  I myself had to largely drop out due to other
> pressures, for example.

But I'm still there, as are IBM, HP people and various other
organizations.  Sun is represented by one person and all the direct
influence the company has is in the OpenGroup vote (one of three).
And here the field is even wider, many more companies have a vote
(including Red Hat).  The other two organizations are IEEE (where the
members of the balloting group make the decisions, individuals but
also implementer votes) and ISO (which is entirely country based).

It is simply not true that any OS manufacturer has any power like
this.  At least not in the last 8 years or so.  And as I said before,
if you can potentially say this about any OS then it is Linux.  The
ENOTSUP issue is a good example.  There is no need for this change in
any of the certified Unixes (since they got there errno assingments
from SysV or at least tested against the Unix test suite early on).
The pressure from the growing number of Linux users made this an issue
and so it got changed.

And take a look at the next revision.  This is mostly an "align with
Linux" edition since Linux already has all the proposed new
functionality.  Solaris has only a small subset and none of the other
OS have anything like it.
