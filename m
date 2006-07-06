Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWGFBMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWGFBMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWGFBMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:12:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59089 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965092AbWGFBMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:12:15 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1152147114.24656.117.camel@cog.beaverton.ibm.com>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
	 <1152147114.24656.117.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 18:12:12 -0700
Message-Id: <1152148332.24656.125.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 17:51 -0700, john stultz wrote:
> I quickly revived my P-D adjustment patch and it does not appear to
> suffer from the same problem with the above droptick change (although
> its only been lightly tested). 
> 
> I realize you may have a more trivial change to this issue, but would
> you consider my method again?
> 
> Vladis: Mind trying the following patch to see if it affects the
> behavior.

Bah! Never mind. Don't bother, trying it.

Of course, only after I send the mail, the same problem reproduces
itself w/ my patch!

grumble.
-john

