Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWCXOyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWCXOyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWCXOyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:54:19 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:45599 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932065AbWCXOyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:54:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MrnR1oGXCr+fjJQSbpJuY1zA032EnRIY7gao4L47OigryIpbk/B2FIa6fWx+rbvEkskpx0K0m9F5jeuzWb/+Sxtdui8YY7Z4kRruMlrrduVDXFOVlscjVguxBeeqaqFArX9w655lzLzvKRXyqBDIEmXzrMO3C/gZNDsSJH6csRo=
Message-ID: <bc56f2f0603240654n4b978cb0p@mail.gmail.com>
Date: Fri, 24 Mar 2006 09:54:17 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced mlock-LRU semantic
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <p73bqvv6ha9.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
	 <p73bqvv6ha9.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am preparing patch for 2.6.16, replace the name "wired" with "pinned".

Potentially, the list could be used for more purposes, than just mlocked pages.

Shaoping Wang

24 Mar 2006 15:36:46 +0100, Andi Kleen <ak@suse.de>:
> "Stone Wang" <pwstone@gmail.com> writes:
> >    mlocked areas.
> > 2. More consistent LRU semantics in Memory Management.
> >    Mlocked pages is placed on a separate LRU list: Wired List.
>
> If it's mlocked why don't you just called it Mlocked list?
> Strange jargon makes the patch cooler? Also in meminfo
>
> -Andi
>
