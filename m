Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLBMS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLBMS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLBMS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:18:28 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:58601 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbVLBMS2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:18:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gGqh2Idq4P4Daiy6kYps60z3HxopAQlK4MKcM3uejo3iP2VfuYlq3K2ZxI7Tnm9UZawbYLSiCrZHNcjVpgFFPIp1yO7O+hHSU0We6lh4FEM55W8GoMhNTOl3UkJ0sdDL4l7XKBnoevfUhcN1ikMPo6ieTf5n1CUjFDAz2/8+CBo=
Message-ID: <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
Date: Fri, 2 Dec 2005 14:18:26 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: Use enum to declare errno values
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
> > There is another reason why enums are better than #defines:

On 12/2/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> This is a reason why enums are worse than #defines.
>
> Unlike in other languages, C enum is not much useful in practices.
> Maybe the designer wanted C to be as fancy as other languages?  C
> shouldn't have had enum imho. Anyway we don't have any strong motives
> to switch to enums.

I don't follow your reasoning. The naming collision is a real problem
with macros. With enum and const, the compiler can do proper checking
with meaningful error messages. Please explain why you think #define
is better for Denis' example?

                                     Pekka
