Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273794AbRIRBP0>; Mon, 17 Sep 2001 21:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273795AbRIRBPQ>; Mon, 17 Sep 2001 21:15:16 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1701 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273794AbRIRBPD>;
	Mon, 17 Sep 2001 21:15:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, Tom Rini <trini@kernel.crashing.org>,
        paulus@samba.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] bzImage target for PPC 
In-Reply-To: Your message of "Mon, 17 Sep 2001 15:01:40 GMT."
             <3BA61054.9C82042B@vnet.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Sep 2001 11:14:18 +1000
Message-ID: <7608.1000775658@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001 15:01:40 +0000, 
Tom Gall <tom_gall@vnet.ibm.com> wrote:
>Tom Rini wrote:
>I'm with Tom on this. Don't apply this one. Additionally in the ppc64 camp we
>like our ppc brothern have been sticking with zImage. It seems (least to me)
>that it's reasonably documented in ppc and ppc64 circles. Perhaps tho it would
>be appropriate to add a short little blurb in the  README for the various
>architectures.

Probably not worth changing.  In 2.5 the type of kernel to build is an
architecture dependent config option.  Users just make installable to
build and make install to install, kbuild 2.5 takes care of everything
else.

