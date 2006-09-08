Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWIHPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWIHPgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWIHPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:36:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbWIHPgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:36:53 -0400
Date: Fri, 8 Sep 2006 08:35:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
In-Reply-To: <4501891D.5090607@sw.ru>
Message-ID: <Pine.LNX.4.64.0609080831530.27779@g5.osdl.org>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
 <44FFF1A0.2060907@openvz.org> <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
 <4501891D.5090607@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Sep 2006, Kirill Korotaev wrote:
> 
> I even checked the email myself and the only difference between "good"
> patches and mine is that mine has "format=flowed" in
> Content-Type: text/plain; charset=us-ascii; format=flowed
> 
> It looks like some mailers replace TABs with spaces when format=flowed
> is specified. So are you sure that the problem is in mozilla?

Hey, what do you know? Good call. I can actually just "S"ave the message 
to a file, and it is a perfectly fine patch. But when I view it in my mail 
reader, your "format=flowed" means that it _shows_ it as being corrupted 
(ie word wrapping and missing spaces at the beginning of lines).

Will apply, thanks. It would be better if your mailer didn't lie about the 
format though (treating the text as "flowed" definitely isn't right, and 
some mail gateways might actually find it meaningful, for all I know).

		Linus
