Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGSBrw>; Thu, 18 Jul 2002 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318430AbSGSBrw>; Thu, 18 Jul 2002 21:47:52 -0400
Received: from holomorphy.com ([66.224.33.161]:32653 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315539AbSGSBrv>;
	Thu, 18 Jul 2002 21:47:51 -0400
Date: Thu, 18 Jul 2002 18:50:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, sfr@canb.auug.org.au
Subject: Re: [PATCH] Initcall depends automagic
Message-ID: <20020719015037.GV1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	sfr@canb.auug.org.au
References: <20020718074421.GN1096@holomorphy.com> <20020719014425.7F9F5415E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020719014425.7F9F5415E@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020718074421.GN1096@holomorphy.com> you write:
>> Any chance you can post the strongly connected components of the
>> dependency graph?

On Fri, Jul 19, 2002 at 11:29:13AM +1000, Rusty Russell wrote:
> Hmm, I don't have that at the moment, but apply the patch and do a
> build, and you'll get a ".defs" file for each .o file, eg
> kernel/futex.o.defs which contains U and T lines (as per nm output)
> showing what symbols it defines and requires.
> Then you can do all the analysis you need 8)

Alrighty, I'll sneak a peek at it and ship whatever code comes out of
it your way.


Cheers,
Bill
