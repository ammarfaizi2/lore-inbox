Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935997AbWK1TxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935997AbWK1TxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936076AbWK1TxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:53:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:37393 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S936077AbWK1TxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:53:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BcXu80SwkkF7CrS9uxn44NfkSREnkU6OlW0Reekjx/wC62YIWacaq79RrBusiK/OgkIrUpsMK5Y3pqwRfTQIRjLBSC5cPKxDNOkjY+5Yao7+UX+3oCsKCuDaHMZYn16egO9dGmwOPT+NtSJC1yIymtQtSVyjbdnSK4HFq6nLj6U=
Message-ID: <5bdc1c8b0611281153l17c2a8f9y28185420f137d0fa@mail.gmail.com>
Date: Tue, 28 Nov 2006 11:53:08 -0800
From: "Mark Knecht" <markknecht@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: 2.6.19-rc6-rt5
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1164735207.1701.19.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061120220230.GA30835@elte.hu>
	 <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
	 <1164735207.1701.19.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2006-11-22 at 06:06 -0800, Mark Knecht wrote:
> > Ingo,
> >    I started building the new kernels a few days ago with your
> > 2.6.19-rc6-rt0 announcement. The kernels have built fine but so far I
> > am unable to build the realtime-lsm package against them so no reason
> > to reboot.
> >
> >    I know there were some comments awhile back about being required to
> > switch to PAM. Has that occurred?
> >
> >    If not then there is a regression issue for realtime-lsm.
>
> As Realtime LSM is an out of tree module and there's no stable kernel
> module API it's impossible to prevent regressions.
>
> That being said, the realtime LSM patch is so simple that it should work
> - how exactly does it fail?
>
> Lee

Hi Lee,
   The failure is a Gentoo sandbax failure. On the surface of it I
didn't really think it was a kernel problem but I know you've pushed
me to move to PAM telling me realtime-lsm wasn't going to work in the
future. I really just wanted to know that PAM was now a requirement
instead of only best practice.

Thanks,
Mark
