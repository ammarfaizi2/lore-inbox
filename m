Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUA0QVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUA0QVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:21:43 -0500
Received: from colin2.muc.de ([193.149.48.15]:55056 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264553AbUA0QVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:21:41 -0500
Date: 27 Jan 2004 17:20:43 +0100
Date: Tue, 27 Jan 2004 17:20:43 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric <eric@cisu.net>, stoffel@lucent.com, ak@muc.de,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040127162043.GA98702@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401261326.09903.eric@cisu.net> <20040126115614.351393f2.akpm@osdl.org> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126215056.4e891086.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you plesae confirm that restoring only -funit-at-a-time again produces
> a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I

It works just fine on the SuSE 9.0 3.3-hammer gcc. 

So far the reports point to some Mandrake gcc 3.3 having problems
(they used an older version of Hammer branch). It's hard to be sure
because everybody having any problem with the kernel seems to like
to report it to this thread :-) But before just disabling
it I would like to track down the problem and see if it's really a 
compiler issue or something that can be fixed in the kernel.

If you really want to disable it I would prefer to only check for that
compiler version and keep it for working 3.3-hammers.

-Andi
