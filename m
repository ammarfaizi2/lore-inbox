Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWABJ5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWABJ5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 04:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWABJ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 04:57:53 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:52424 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932342AbWABJ5x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 04:57:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RQRcXUEKlUH1FIyd93AzPeCdo52NlhI7XDnFQdXr/VsPaemgtKtXQ3vei2K8usaO71P7V1crzkGxoMcDSpuq8fqCkRNugbYR2HuRSNIUw8Xi4TbaRHQQdH4tGzjRDshbkbIivhro7RTKyG6JPMChBFtF0xak8wQkYpkVvql1I8o=
Message-ID: <5a2cf1f60601020157w1ca252e0s1fe8fa3e839e54d4@mail.gmail.com>
Date: Mon, 2 Jan 2006 10:57:52 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: [OT] Re: MPlayer broken under 2.6.15-rc7-rt1?
Cc: Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136118354.17830.21.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
	 <1136114772.17830.20.camel@laptopd505.fenrus.org>
	 <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
	 <1136118354.17830.21.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > Although I like the idea of making the vendors of binary modules
> > really aware of the costs they introduce with regard to debug issues
> > on tainted system, if I was them, the first thing I would say is
> > "contact the vendor of the part of the system that changed", i.e. the
> > kernel.
>
> the good ones don't, and investigate. The bad ones... do you really want
> their code in your kernel??

I should have emphasized the "system that changed" part over the
"contact the vendor" one.

I believe most of us have to deal with time as a limited constraint.
And the issue investigation heuristic that considers that an issue
most likely results from the latest change in your configuration gives
a good result most of the time. Software, hardware, we all do it.

So maybe it's a bad vendor practise to *redirect* people somewhere
else, but it's I think a good engineering practise to work by
*isolating changes*. Kernel people work by isolating binary from
non-binary code. Vendor probably work by isolating unknown
configurations from preferred known working configurations. Everyone
just tries to do what best suit their development environment and
constraints.

Cheers,

Jerome

(and Happy Linux Year 2006)
