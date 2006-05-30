Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWE3Wbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWE3Wbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWE3Wbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:31:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:48317 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932527AbWE3Wbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:31:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJa2qNftL1Bp7ak/ane1LKAolaZ/Fsu2PksV6oEXoFOeSQyg5R6IIWB8IZ1520T5i9OETBKc/+PbE8EDhi1Et230wQAhMgFxZcr313QUr1FHfYJ8jbwVg/RDFFTergQ9Zjbqyg/nXM3KCn4teYHTfuktGBNzLj+AGWR/YFmBWa4=
Message-ID: <6bffcb0e0605301531u55058431h9941bc01a2143a4e@mail.gmail.com>
Date: Wed, 31 May 2006 00:31:34 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060530222954.GA3746@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
	 <20060530194259.GB22742@elte.hu>
	 <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
	 <20060530220931.GA32759@elte.hu> <20060530221850.GA1764@elte.hu>
	 <20060530222608.GA3274@elte.hu> <20060530222954.GA3746@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > * Ingo Molnar <mingo@elte.hu> wrote:
> >
> > > PREEMPT wasnt the problem but CONFIG_DEBUG_STACKOVERFLOW (at least).
> > > There's some other debug option that seems incompatible too - i'm
> > > still trying to figure out which one.
> >
> > narrowed it down to:
>
> CONFIG_PROFILE_LIKELY it is, please disable it in your config, along
> with CONFIG_DEBUG_STACKOVERFLOW:

Ok, thanks.

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
