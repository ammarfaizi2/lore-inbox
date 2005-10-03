Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVJCF7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVJCF7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVJCF7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:59:34 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:26971 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932163AbVJCF7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/sjfC4wHOxKyRZmqUv2G+5QFcDPY1BZM8eszWIq/XZD3tcCYlJ/A2HeTu0V7oOu5q49pNZfrIoGqvjgtqF0PcA+RtfCM1CbY4Zs56Y9OCxR9nxizSseHwVkmMRsboaLSvhYoQJPxKneM7d5WKeaeZVdzQBXU+1s5nwo7ThymyE=
Message-ID: <aec7e5c30510022259v46316af2wff1ee92f1ce3d288@mail.gmail.com>
Date: Mon, 3 Oct 2005 14:59:31 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Cc: haveblue@us.ibm.com, magnus@valinux.co.jp, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051002223352.6d21a8bc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <1128093825.6145.26.camel@localhost>
	 <20051002202157.7b54253d.pj@sgi.com>
	 <aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
	 <20051002223352.6d21a8bc.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Paul Jackson <pj@sgi.com> wrote:
> Magnus wrote:
> > So, Paul, please let me know if you prefer SMP || NUMA or no
> > depencencies in the Kconfig.
>
> In theory, I prefer none.  But the devil is in the details here,
> and I really don't care that much.
>
> So pick whichever you prefer, or whichever provides the nicest
> looking code or patch, or flip a coin ;).

I'm tempted to consult the magic eight-ball, but I think I will stick
with the advice from Takahashi-san instead. =) So, the dependency will
be removed.

/ magnus
