Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWIHPMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWIHPMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIHPMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:12:33 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48241 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750753AbWIHPMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:12:32 -0400
Message-ID: <4501891D.5090607@sw.ru>
Date: Fri, 08 Sep 2006 19:15:41 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <44FFF1A0.2060907@openvz.org> <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>Does the patch below looks better?
> 
> 
> Yes. 
> 
> Apart from the whitespace corruption, that is.
> 
> I don't know how to get mozilla to not screw up whitespace.

What is funny is that mozilla doesn't screw up whitespaces.
2 people checked that patch from the email applies to the kernel.

I even checked the email myself and the only difference between "good"
patches and mine is that mine has "format=flowed" in
Content-Type: text/plain; charset=us-ascii; format=flowed

It looks like some mailers replace TABs with spaces when format=flowed
is specified. So are you sure that the problem is in mozilla?

Thanks,
Kirill

