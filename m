Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWHXPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWHXPwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWHXPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:52:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:51382 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751596AbWHXPwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:52:39 -0400
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
From: Dave Hansen <haveblue@us.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Rohit Seth <rohitseth@google.com>,
       Matt Helsley <matthltc@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <Pine.LNX.4.62.0608241128280.5478@pademelon.sonytel.be>
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru>
	 <1156374231.12011.61.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0608241128280.5478@pademelon.sonytel.be>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 08:52:22 -0700
Message-Id: <1156434742.12011.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 11:30 +0200, Geert Uytterhoeven wrote:
> > +#define THREAD_SHIFT 1
>                         ^
> Shouldn't this be 13? 

Yep.  Thanks! 

I need to go over the whole things again and proofread. 

-- Dave

