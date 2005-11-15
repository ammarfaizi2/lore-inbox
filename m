Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVKOCkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVKOCkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVKOCkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:40:08 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:31911 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932266AbVKOCkG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:40:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MPvzot9upHrlN9tJh+nZ9mWz6aU1h8Fqc8TT6+1Coy1UAXKtxDCPklqHCLM4LdDU21PQGT1FjwguJ29ScspSbsjKJf/ehVo4msyYG4pjpHKF1iJtoUQlgeO2pHhO+s5klBIIBM/SpHF7o0js+HfhRF0rjxRu0Li/QLp8svi9XTQ=
Message-ID: <489ecd0c0511141840t4e7ba87ftfdba8c287063565f@mail.gmail.com>
Date: Tue, 15 Nov 2005 10:40:05 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <1131954765.2821.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
	 <20051112214741.GB16334@kroah.com>
	 <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
	 <1131954765.2821.6.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/05, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > > The process is like maintaining any other part of the kernel:
> > >   - Try to make sure it works on all releases (harder to do with a full
> > >     arch, I know, but not impossible.)
> >
> >   Does this include all the rc releases? and the 2.6.14.x releases?
> >
> > >   - keep it up to date with bugfixes and the such
> >
> >   So the process is: when kernel release a new version, we should
> > update our arch related files to the new kernel, then send you the
> > patch. Am I right?
>
> well the idea is that you fix things BEFORE the kernel is released for
> final, so that the final releases work out of the box (well out of
> kernel.org). This implies that you sort of track the git tree on a
> regular basis, but at minimum look at the first -rc kernel.

  yep, that's our plan. And for the 2.6.14.1, 2.6.14.2... versions, do
we have to follow every of them?

>
>
