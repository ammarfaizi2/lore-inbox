Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWHRRbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWHRRbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHRRbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:31:39 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:58267 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751430AbWHRRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:31:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uMmPQxcrdg1uMrq27Op0tbivvXHJX+0uoE1lz1UURrWVMirY1CQNa58bM3AOKNb7ZaFlmky4xu0pZjva14NKqn5y2SypTqzWAA9GERA+3LE4TfvCcOMfjvgaUwuIqB50oqG93umTq8xkIgGWjaOiLtuy2lb+sBCGj/PkVcWdLis=
Message-ID: <8032e0b00608181031g20441a05s49c92820d34d3df3@mail.gmail.com>
Date: Fri, 18 Aug 2006 23:01:37 +0530
From: "Ashok Shankar Das" <ashok.s.das@gmail.com>
To: "Chris Wedgwood" <cw@f00f.org>
Subject: Re: PROBLEM Please Help
Cc: "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060818064338.GA28939@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8032e0b00608172322y6e77b9d9v3f8cd73e8a7b454d@mail.gmail.com>
	 <20060817.233910.78711257.davem@davemloft.net>
	 <20060818064338.GA28939@tuatara.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Aug 17, 2006 at 11:39:10PM -0700, David Miller wrote:
>
> > The IRQ for the network device is not being enabled properly.  The
> > MOUSE happens to be on the same shared interrupt as the network
> > device so when you move it the interrupt handler for the network
> > device gets invoked too.
> >
> > Just my guess...
>
> Some (a lot) of VIA silicon needs a quirk for interrupts to work
> properly (ACPI should do the work for us but it's not reliable).
>
> Please apply:
>
>     http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/pci-quirk_via_irq-behaviour-change.patch
>
> and see if that helps.
>
I will try this On Monday ;)
Till then rest in peace.

But i will post problems if get unsuccess ;)

-- 
Thanks
Ashok.
-------------
