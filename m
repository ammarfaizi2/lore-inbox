Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVADNAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVADNAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVADNAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:00:32 -0500
Received: from smtpout.mac.com ([17.250.248.45]:55753 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261593AbVADNAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:00:23 -0500
In-Reply-To: <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk> <9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85546E06-5E50-11D9-A816-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, Willy Tarreau <willy@w.ods.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       William Lee Irwin III <wli@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Tue, 4 Jan 2005 13:59:51 +0100
To: Rik van Riel <riel@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 13:36, Rik van Riel wrote:

> On Tue, 4 Jan 2005, Felipe Alfaro Solana wrote:
>
>> I don't pretend that kernel interfaces stay written in stone, for 
>> ages. What I would like is that, at least, those interfaces were 
>> stable enough, let's say for a few months for a stable kernel series, 
>> so I don't have to keep bothering my propietary VMWare vendor to fix 
>> the problems for me, since the
>
> How much work are you willing to do to make this happen ? ;)

As much as needed :-)

> It would be easy enough for you to take 2.6.9 and add only
> security fixes and critical bugfixes to it for the next 6
> months - that would give your binary vendors a stable
> source base to work with...

I would... if it was easy enough to find some form of a security 
patches pool. It's usually difficult to find a site where I can 
download security patches for older versions of vanilla kernels. I have 
the feeling that this security fixes go mainstream onto the latest 
kernel versions, leaving users in hands of their distribution (either 
to upgrade to a new distribution kernel, or waiting for the 
distribution vendor to backport).

Thus, sometimes people are forced to upgrade to a new kernel version as 
such security patches either don't exist for older kernel versions, are 
difficult to find, or need backporting (and I'm not knowledgeable 
enough to backport nearly half of them), and since the new kernel 
version introduces new features -- which sometimes do break existing 
propietary software -- users starts complaining.

However, it's true that distributions, like Red Hat or Fedora, try at 
its best to keep the kernel as stable as possible. For example, FC3 
seems to sport something like a 2.6.9 kernel, but sometimes those 
kernels are so heavily patched that some closed-source software doesn't 
work.

I know I can choose open software and hardware vendors compatible with 
Linux, but sometimes I cannot. I like VMware, and I use it a lot. I'm 
not willing to sacrifice it, and that's the reason I think 2.6 must 
fork as soon as possible into 2.7.

