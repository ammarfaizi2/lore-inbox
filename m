Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWATQ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWATQ6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWATQ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:58:13 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:48304 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbWATQ6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:58:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uVj7MrGNMFA94Ia2uec5CgPl69SWjMiiK9Qe1s9gNxO0DuuHT8KisaYhTkEzlCKNkm0fbyzAq74Ao5iMfuCCqP7A2Gqt4NXs9vK6nBSHAISEoeZllp6Yj5rmcRalNkU0rX+Z0wnDEWAOTB6Gf0+CwYc6WkBqwBcB4PFQP8qdPHU=
Message-ID: <40f323d00601200858i7a2dcedbi2b8d648b961da5d5@mail.gmail.com>
Date: Fri, 20 Jan 2006 17:58:09 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
Cc: Harald Welte <laforge@netfilter.org>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	 <20060120162317.5F70722B383@anxur.fi.muni.cz>
	 <20060120163619.GK4603@sunbeam.de.gnumonks.org>
	 <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
	 <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 20 Jan 2006, Benoit Boissinot wrote:
> >
> > On x86 (32bits), i have the same i think:
>
> Interestingly, __alignof__(unsigned long long) is 8 these days, even
> though I think historically on x86 it was 4. Is this perhaps different in
> gcc-3 and gcc-4?

I use gcc-4 (gcc version 4.1.0-beta20060113), but i can try with
something more conservative.

regards,

Benoit
