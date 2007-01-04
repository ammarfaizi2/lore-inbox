Return-Path: <linux-kernel-owner+w=401wt.eu-S1030189AbXADUdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbXADUdq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbXADUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:33:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1032 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030189AbXADUdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:33:45 -0500
Date: Thu, 4 Jan 2007 20:33:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Zach Brown <zach.brown@oracle.com>, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20070104203313.GA3953@ucw.cz>
References: <20061227153855.GA25898@in.ibm.com> <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com> <6f703f960701021640y444bc537w549fd6d74f3e9529@mail.gmail.com> <A85B8249-FC4E-4612-8B28-02BC680DC812@oracle.com> <6f703f960701021718qb85f4bdg58d8ee0923376191@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f703f960701021718qb85f4bdg58d8ee0923376191@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2007-01-02 16:18:40, Kent Overstreet wrote:
> >> Any details?
> >
> >Well, one path I tried I couldn't help but post a blog 
> >entry about
> >for my friends.  I'm not sure it's the direction I'll 
> >take with linux-
> >kernel, but the fundamentals are there:  the api should 
> >be the
> >syscall interface, and there should be no difference 
> >between sync and
> >async behaviour.
> >
> >http://www.zabbo.net/?p=72
> 
> Any code you're willing to let people play with? I could 
> at least have
> real test cases, and a library to go along with it as it 
> gets
> finished.
> 
> Another pie in the sky idea:
> One thing that's been bugging me lately (working on a 9p 
> server), is
> sendfile is hard to use in practice because you need 
> packet headers
> and such, and they need to go out at the same time.

splice()?
							Pavel

-- 
Thanks for all the (sleeping) penguins.
