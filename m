Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWDXVuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWDXVuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDXVuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:50:50 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:42849 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751331AbWDXVut convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:50:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iO0QG7JyYa1ECVI333oVH92qWeo86JRDv82wsD5Cu4igg6Z3767x/ExMRTjfd1C2BjPFZklPtjbgKj+BINM6LFNuBcRN/f7GHPSDzcrAZSTePnVQL9QARlcAJZZy/pLtCSjFPkn6+70NxykRX8pM+AOpNrqaGmzIrisf1OpHeJ4=
Message-ID: <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:50:47 -0700
From: "marty fouts" <mf.danger@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:

> What else can C++ do that C can not?

Inheritance, templates...

I would never argue in favor of converting any large existing
application, especially the Linux kernel, from C to C++ by introducing
C++ into part of it; for a lot of reasons, but it is possible to write
a reasonable OS kernel in C++ and take advantage of "C++ as a safer C"
(Koenig) to write clearer, shorter code in a lot of instances.

Unfortunately, it's almost as easy to write bad C++ as it is to write
bad C (Fortran in any language) but we (the community) have a lot more
experience in writing C kernels, so we're more familiar with how to
avoid bad C than we are with how to avoid bad C++.

The existance of Bulwer-Lytton does not disprove that good prose can
be written in English, nor does silly abuse of overloading disprove
that good code can be written in C++.

Oh, and yeah, a = b + c *is* more readable than

a = malloc(strlen(b) + strlen(c));
strcpy(a,b);
strcat(a,c);

and contains fewer bugs ;)
