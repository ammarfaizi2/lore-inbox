Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWCMKYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWCMKYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWCMKYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:24:20 -0500
Received: from host-84-9-202-225.bulldogdsl.com ([84.9.202.225]:3518 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750753AbWCMKYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:24:20 -0500
Date: Mon, 13 Mar 2006 10:23:21 +0000
From: Ben Dooks <ben@fluff.org>
To: James Yu <cyu021@gmail.com>
Cc: Ben Dooks <ben@fluff.org>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: weird behavior from kernel
Message-ID: <20060313102321.GC25816@home.fluff.org>
References: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com> <20060312084632.GB21493@w.ods.org> <60bb95410603120125n24c3a283xe1fabeb255c8c59b@mail.gmail.com> <20060312213720.GB25816@home.fluff.org> <60bb95410603122341w74ca1d97k9bda52fd71d06d18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bb95410603122341w74ca1d97k9bda52fd71d06d18@mail.gmail.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 03:41:44PM +0800, James Yu wrote:
> It's a custom board I got, and the official 2.6 doesn't work on it. So
> I have to use 2.4.

I assume that you had to alter 2.4 to work with your board, so why
is 2.6 so much more difficult?

We have 5 custom boards here, and we use 2.6. It does not take long
to add a board initialisation file into arch/arm/mach-s3c2410/
 
> I tried -fno-strength-reduce option, and it doesn't seem to work though.
> Still looking for solutions~
> 
> 
> On 3/13/06, Ben Dooks <ben@fluff.org> wrote:
> > On Sun, Mar 12, 2006 at 05:25:11PM +0800, James Yu wrote:
> > > The major reason to choose 2.4.18 as my dev base is that the dev is
> > > ment to be carried out on a custom ARM board, and there isn't any
> > > 2.6's port available.
> >
> > What functionality do you need which is not in the current
> > 2.6 kernel series?
> >
> > --
> > Ben (ben@fluff.org, http://www.fluff.org/)
> >
> >   'a smiley only costs 4 bytes'
> >
> 
> 
> --
> James
> cyu021@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
