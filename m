Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFXSZB>; Mon, 24 Jun 2002 14:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFXSZA>; Mon, 24 Jun 2002 14:25:00 -0400
Received: from fmr03.intel.com ([143.183.121.5]:3569 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id <S314634AbSFXSY7>;
	Mon, 24 Jun 2002 14:24:59 -0400
Message-Id: <200206241824.g5OIOgP30024@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] tcore for 2.5.23 kernel
Date: Mon, 24 Jun 2002 11:32:21 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mark@thegnar.org
References: <200206191640.g5JGeTP21950@unix-os.sc.intel.com> <20020622143803.GB110@elf.ucw.cz>
In-Reply-To: <20020622143803.GB110@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the input, I'll tweak these things on my next re-base of the patch.

--mgross

On Saturday 22 June 2002 10:38 am, Pavel Machek wrote:
> Hi!
>
> > This patch has been tested on my SMP system and is stable. I would like
> > very much to see this feature added to the 2.5.x kernels and more milage
> > given to it.
>
> Minor comments:
> > +//
> > +// grab all the rq_locks.
> > +// current is the process dumping core
> > +//
>
> Do not use C++ style comments in kernel.
>
> > +				threads[OnCPUCount] = p;
>
> on_cpu_count, this is gnu stile, not java.
> 									Pavel
