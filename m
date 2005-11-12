Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVKLSAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKLSAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKLSAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:00:38 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:22948 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932444AbVKLSAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:00:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YADvDpALVk4/XOblco5pa/YPOIgllIrMvTXguqWMtOjv/XkWjDoY1HhSv9osHWtUPcff/kiBo4RNUmNec7jACaDrM1kaXvSxIhoIQxP8f7lljXZM/Vz+T/0lfCjhL4FZ0cRNGmEDCfkhQfVTCaO5A4EfwHS32e9gDe1A2jYlRPc=
Message-ID: <6bffcb0e0511121000s320bc9f4r@mail.gmail.com>
Date: Sat, 12 Nov 2005 19:00:37 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051111174732.02455c83.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <6bffcb0e0511111631h52ff73e1q@mail.gmail.com>
	 <20051111165156.05391fef.akpm@osdl.org>
	 <6bffcb0e0511111730nc8ae355s@mail.gmail.com>
	 <20051111174732.02455c83.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > I will try to reproduce it, but according to
> > http://klive.cpushare.com/2.6.14-mm1/?order_by=kernel_group&where_machine=all&branch=mm&scheduler=all&smp=all&live=all&ip=all
> > I have been using 2.6.14-mm1 about 48 hours with 12 reboots and this
> > problem appeared only once.
>
> ah-hah.  This sounds rather like Reuben Farrelly's e100 failure - something
> seems to be making PCI initialisation go stupid if CONFIG_PREEMPT is
> enabled.
>
> It would be interesting if you could reboot sufficiently often to work out
> whether disabling CONFIG_PREEMPT fixes things up.
>
>

Sorry, but unfortunately I can't even reproduce it.

Regards,
Michal Piotrowski
