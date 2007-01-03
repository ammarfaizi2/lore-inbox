Return-Path: <linux-kernel-owner+w=401wt.eu-S1750905AbXACQKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXACQKw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbXACQKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:10:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54638 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXACQKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:10:51 -0500
Date: Wed, 3 Jan 2007 08:06:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <20070103142839.311717f2@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701030805530.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
 <20070103124410.4cb191dd@localhost.localdomain> <1167831136.3095.8.camel@laptopd505.fenrus.org>
 <20070103142839.311717f2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Alan wrote:
>
> > cmov is effectively the same cost as a compare and jump, in both cases
> > the cpu needs to do a prediction, and on a mispredict, restart.
> 
> On a P4 it appears to be slower than compare/jump in most cases

On just about EVERYTHING it's slower than compare/jump. See my other post 
on why, together with a (largely untested) test app.

		Linus
