Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVIOEkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVIOEkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVIOEkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:40:32 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:11175 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030407AbVIOEka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:40:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMVpUIEbkvI1uyL0IQ06djIGVhbrHrp69V2fyoJP86i1zDtpoz8jdVZqV8T1xx6xMCwVzQn/mxft7lF65TUYm6qRYXuvXRJaRkT4cHK1jmOcd0zwnQNkb0uk0W1bq7cKxTtbfGR/uMH+ojw9kyriD15i5+6gvHCdjeYkkTv87Kk=
Message-ID: <355e5e5e050914214025feee82@mail.gmail.com>
Date: Thu, 15 Sep 2005 00:40:27 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: lkosewsk@gmail.com
To: jim.ramsay@gmail.com
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4789af9e05090612023fb8517c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
	 <4789af9e050823154364c8e9eb@mail.gmail.com>
	 <430BA990.9090807@mvista.com> <430BCB41.5070206@s5r6.in-berlin.de>
	 <355e5e5e05082407031138120a@mail.gmail.com>
	 <4789af9e05082408111c4a6294@mail.gmail.com>
	 <4789af9e05082409121cc6870@mail.gmail.com>
	 <4789af9e0508291223435f174@mail.gmail.com>
	 <4789af9e05090612023fb8517c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> However, I have seen the occasion where a single IRQ is used to signal
> both a DMA completion AND a hotplug event.  Of course in this case the
> hotplug event itself would be ignored completely.
> 
> So I would recommend getting rid of that check entirely.

Hey Jim,

Not that I disbelieve you, but do you have an example of a controller
where this happens?  I've done a lot of testing and never seen this...

Luke Kosewski
