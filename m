Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTAOTUL>; Wed, 15 Jan 2003 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTAOTUL>; Wed, 15 Jan 2003 14:20:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266983AbTAOTUK>;
	Wed, 15 Jan 2003 14:20:10 -0500
Message-Id: <200301151928.h0FJSuW17921@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ian Wienand <ianw@gelato.unsw.edu.au>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>, cliffw@osdl.org
Subject: Re: [ANNOUNCE] contest benchmark v0.60 
In-Reply-To: Message from Ian Wienand <ianw@gelato.unsw.edu.au> 
   of "Wed, 15 Jan 2003 16:24:00 +1100." <20030115052400.GJ21742@cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Jan 2003 11:28:56 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 15, 2003 at 03:39:34PM +1100, Con Kolivas wrote:
> > more I tried to add to it. Also there were subtle things happening in the 
> > BASH version that made for much more variation in results than this version. 
> 
> I agree, it had begun to outgrow it's bash roots (e.g. i think it was
> the ratio section with variables named a b c d e which drove me nuts
> when I couldn't figure out which one was giving me a zero value).
> 
> > Possibly but clearly c has no major limitations once the hard part (the 
> > wrapper for the other applications) has been done. 
> 
> I would disagree.  For example, playing tricks with strings,
> pipes/redirects and files in C is a complete pain, compared with
> perl/python.  Most of the things I changed with the orignal bash
> version were in this subset, and it allowed me to customise it for
> what we were doing quickly and easily. 
> 

Good point. 
One other note, the C version should have a much smaller memory footprint then
Perl or Python - less likely to perturb test results. 
Speaking for myself, i think this is such a small pile of code, it might be fun
to have a parallel Perl/Python version. (it would be a good excuse for me to 
learn some Python)
My personal choice would be C to generate the data and Perl to pretty-print 
it.

 I need to get into the code more for STP integration, so i'll have more 
opinons
soon :)
cliffw


> -i
> ianw@gelato.unsw.edu.au
> http://www.gelato.unsw.edu.au
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


