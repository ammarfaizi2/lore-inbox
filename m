Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUH0SN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUH0SN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUH0SN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:13:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:39649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266837AbUH0SNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:13:21 -0400
Date: Fri, 27 Aug 2004 11:13:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Christoph Hellwig <hch@infradead.org>, Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <1093628254.15313.14.camel@gonzales>
Message-ID: <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>
  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Xavier Bestel wrote:
> 
> What if someone steps up and want to maintain and extend this piece of
> code ? Will you forbid him (as in "not in my tree") ?

I'd suggest you contact the people who have worked on that driver (there's 
certainly people outside of nemosoft, at least according to the 
changelogs) and see what they feel like and try to gauge how much they 
were part of driver development. 

I'd _really_ prefer not to step on original authors toes. 

Quite frankly, the best option is for people who love the driver to plead
with the author(s). It's totally pointless to flame him/them, that will
just irritate them and make them less likely to be inclined to say "sure,
go ahead and maintain the old driver".

But Greg is right - we don't keep hooks that are there purely for binary
drivers. If somebody wants a binary driver, it had better be a whole
independent thing - and it won't be distributed with the kernel.

			Linus
