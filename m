Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWDVRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWDVRPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWDVRPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:15:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52884 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750740AbWDVRPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:15:45 -0400
Date: Sat, 22 Apr 2006 12:39:08 +0200
From: Bryan =?utf8?Q?=C3=98stergaard?= <kloeri@gentoo.org>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
       Bob Tracy <rct@gherkin.frus.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
       rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060422103907.GA7693@mail.fl.dk>
References: <20060420215723.GA3949@bigip.bigip.mine.nu> <20060421024304.2D851DBA1@gherkin.frus.com> <20060421081500.GA3767@bigip.bigip.mine.nu> <20060421092127.GA7382@bigip.bigip.mine.nu> <20060421095028.GA8818@bigip.bigip.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060421095028.GA8818@bigip.bigip.mine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 11:50:28AM +0200, Mathieu Chouquet-Stringer wrote:
> On Fri, Apr 21, 2006 at 11:21:27AM +0200, Mathieu Chouquet-Stringer wrote:
> > The bad news is my test case, compiled with a native gcc version 3.4.4
> > and binutils version 2.16.1 doesn't work as expected.  So maybe it's
> > combination of gcc/binutils?  I'm booting the new kernel just to confirm
> > that 3.4.4 and 2.16.1 do not work.
> 
> A native gcc 3.4.4 and binutils 2.16.1 do not work...  What should we
> try next?
> 
For what it's worth, I've found gcc 3.4.4 to be bad on gentoo. If I
compile any binutils-2.16.[01] versions with 3.4.4 ld segfaults when
trying to compile gmp. I don't know of any binutils related problems
when using gcc 3.4.6 currently.

Regards,
Bryan Østergaard
