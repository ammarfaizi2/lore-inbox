Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTHYTk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTHYTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:40:57 -0400
Received: from www.13thfloor.at ([212.16.59.250]:3532 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262188AbTHYTku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:40:50 -0400
Date: Mon, 25 Aug 2003 21:41:03 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825194103.GC28525@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at> <20030825122906.79d755d4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825122906.79d755d4.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:29:06PM -0700, Randy.Dunlap wrote:
> On Mon, 25 Aug 2003 21:13:39 +0200 Herbert Pötzl <herbert@13thfloor.at> wrote:
> 
> | 
> | Hi Everyone!
> | 
> | this time not sooo off topic but ...
> | 
> | anyway, ist there some kind of overview how
> | large the basic C types are on the different
> | architectures Linux runs on?
> | 
> | char, short, int, long, long int, long long, ...
> 
> >From gcc mailing list today: <quote>
> 
> All GCC targets (except perhaps some specialized targets for certain DSPs
> and microcontrollers) support 64-bit integers.
> 
> Almost all GCC targets are either "ILP32" or "LP64".
> 
> For ILP32:
> 	short is 16 bits
> 	int, long, pointers are 32 bits
> 	"long long" is 64 bits
> 
> For LP64:
> 	short is 16 bits
> 	int is 32 bits
> 	long, pointers, and "long long" are 64 bits
> 
> None of this requires a specific version, as all these types have been
> around for a long time.
> </quote>
> 
> Also see Ch. 10 of the LDD book:
>   http://www.xml.com/ldd/chapter/book/ch10.html

ahh there is the tabular I was looking for ...

many thanks,
Herbert

> --
> ~Randy   [mantra:  Always include kernel version.]
> "Everything is relative."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
