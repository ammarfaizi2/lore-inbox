Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSJCR2E>; Thu, 3 Oct 2002 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJCR2E>; Thu, 3 Oct 2002 13:28:04 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:63474 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261497AbSJCR2D>; Thu, 3 Oct 2002 13:28:03 -0400
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
	logging macros, SCSI RAIDdevice)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jbradford@dial.pipex.com, jgarzik@pobox.com, kessler@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       saw@saw.sw.com.sg, rusty@rustcorp.com.au, richardj_moore@uk.ibm.com
In-Reply-To: <Pine.LNX.4.44.0210030952010.2067-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210030952010.2067-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 18:40:51 +0100
Message-Id: <1033666851.28814.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 17:56, Linus Torvalds wrote:
> And that "old_stat()" thing really ought to go some day.. It's not much of
> a support burden, and yeah, we can point people to "that old a.out binary
> from 1993 still works fine", so I guess we'll keep it another ten years,
> but at this point that has less to do with technical judgement than with
> sentimentality, I think ;^)
> 
> But yeah, I think on the whole we've done pretty well on being binary 
> compatible.

Im not sure we want to throw those things out. However all the stuff
that went out before libc5 could go into a legacy.c file that is only
liked if a.out loaders are present

