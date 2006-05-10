Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWEJEyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWEJEyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 00:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWEJEyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 00:54:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5483 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964812AbWEJEyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 00:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nqVMbmu9XbPGP45at0xFzywbg668tvUggEp2Os3QHOb/eU3M6ynVv23xbeh09Gn4zWoC7IfUInu5iBQaokqrqLDJhe53D9cr1gdNM790P8a9F4iGeMZ7BH8QHSjnTSfaR/fpSQFDti831BRfki7CeUiG8FxbuQd0DFPIdpcY0/0=
Message-ID: <305c16960605092154v282b7fb4s7c2333443b73f2af@mail.gmail.com>
Date: Wed, 10 May 2006 01:54:14 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
Cc: "Daniel Walker" <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060510032912.GC1794@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
	 <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
	 <20060510032912.GC1794@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Olof Johansson <olof@lixom.net> wrote:
> On Wed, May 10, 2006 at 12:14:45AM -0300, Matheus Izvekov wrote:
> > On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> > >unsigned long may not always be 32 bits, right ? This patch fixes the
> > Incorrect, its defined as 32bits for every standard C compiler
>
> Wrong. The only environment I'm aware of that has only P64 is Win64.
>

Yeah sorry, now im aware of it, sorry for the noise
