Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWBIThx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBIThx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWBIThx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:37:53 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:30797 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbWBIThw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:37:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uag5YnA8fP7NkVQ7BlNJ+7GD0K2Pk0+q80mjqWepCGt8wB34o4gIhdzhm0Hjz6/dyPU1hF4Qmm3zDIODvJjF0/n7YyCHUWQUr6rKoDWimsvmFiiQAuWr8iTtUAkQOH+bavmrB0HBL2ZvtiNYdZwYt3nFGG42QBPVQYJ9tgW5X2c=
Message-ID: <cbec11ac0602091137p4ee233bdgdcfbf3d6cb62a62f@mail.gmail.com>
Date: Fri, 10 Feb 2006 08:37:48 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: bb@kernelpanic.ru
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Yoseph Basri <yoseph.basri@gmail.com>, linux-kernel@vger.kernel.org,
       NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <43EB98B0.4@kernelpanic.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
	 <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
	 <43EB9548.9060504@kernelpanic.ru>
	 <cbec11ac0602091125w5a5a7c6em8462131e9f9b24dc@mail.gmail.com>
	 <43EB98B0.4@kernelpanic.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
> Hello, Ian McDonald.
>
> On 09.02.2006 22:25 you said the following:
>
> > Is it possible for you to download 2.6.16-rc2 or similar and see if it
> > goes away?
>
> It'll be better, if I get only patch fixs that problem, not all 2.6.16-rc2.
>
Oops I didn't read Jesse's message earlier properly.

That patch which probably fixed it is (from his message):
I think the commit id that is missing from 2.6.14.X is
fb5f5e6e0cebd574be737334671d1aa8f170d5f3

but here is the web link if i gave the wrong info
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fb5f5e6e0cebd574be737334671d1aa8f170d5f3
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
