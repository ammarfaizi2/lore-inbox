Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbWLRX7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWLRX7a (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWLRX7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:59:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60770 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbWLRX73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:59:29 -0500
Date: Mon, 18 Dec 2006 15:59:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <17799.10706.834077.676728@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0612181554430.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
 <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
 <orpsah6m3s.fsf@redhat.com> <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
 <or64c96ius.fsf@redhat.com> <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
 <17799.10706.834077.676728@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Paul Mackerras wrote:
>
> There is in fact a pretty substantial non-technical difference between
> static and dynamic linking.  If I create a binary by static linking
> and I include some library, and I distribute that binary to someone
> else, the recipient doesn't need to have a separate copy of the
> library, because they get one in the binary.

I agree, and I do agree that it's a real difference. 

I personally think that it's the "aggregation" issue, not a "derivation" 
issue, but I'll freely admit that it's just my personal view of the 
situation.

> In other words, static linking gives the recipient a "free" copy of
> the library, but dynamic linking doesn't.  That is why some companies'
> legal guidelines have quite different rules about the distribution of
> binaries, depending on whether they are statically or dynamically
> linked.

Yes. There is not doubt at all that regardless of anything else, if you 
link statically, you at the VERY LEAST need to have the right to 
distribute the library as part of an "aggregate work". 

> So therefore I don't think you can reasonably claim that static
> vs. dynamic linking is only a technical difference.  There are clearly
> other differences when it comes to distribution of the resulting
> binaries.

Yes. And I have actually talked about this exact issue - even in the 
absense of any "derivation" from the library, the fact that static linking 
includes a _copy_ of the library does mean that you have to have the right 
to distribute that particular copy. 

Now, under the GPL, aggregate distribution is allowed, but you still do 
need to follow the other GPL rules (ie you would need to distributed 
sources for the library - even if you don't necessarily distribute sources 
to the binary you linked _with_).

So there's no question that "dynamic linking" simplifies issues, by virtue 
of not even distributing any library code at all. I absolutely agree about 
that part.

		Linus
