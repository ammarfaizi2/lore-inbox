Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVCDShH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVCDShH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDSe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:34:57 -0500
Received: from mail.portrix.net ([212.202.157.208]:51101 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262971AbVCDSc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:32:27 -0500
Message-ID: <4228A9A2.9020306@ppp0.net>
Date: Fri, 04 Mar 2005 19:32:02 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk> <039001c520e0$4ea3fbe0$0f01a8c0@max> <20050304181110.A16178@flint.arm.linux.org.uk>
In-Reply-To: <20050304181110.A16178@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Mar 04, 2005 at 05:33:33PM -0000, Richard Purdie wrote:
> 
>>I'm in two minds though as generating 
>>your own from openembedded isn't difficult. Writing instructions for setting 
>>up oe to build it may be the best option.
> 
> 
> Two things - are you sure that openembedded contains the patches to
> fix the two biggest binutils issues we have, as documented on
> http://www.arm.linux.org.uk/developer/toolchain/ ?
> 
> Secondly, are you seriously suggesting people like Jan Dittmer, who
> provide a cross-architecture service should jump through some loops
> just to get a working toolchain for the ARM architecture?

As long it is documented and it _works_ that's no problem. But it was
quite a hassle to get working cross-compilers for all 23 archs
to build, because for some there is no real documentation which
target is the correct one and upstream gcc and/or binutils sometimes
don't compile.
For example where can I find information about the arm26 arch?
I suppose it can be build with a normal arm toolchain (and the
breakage looks like a real compiler failure), but is this documented
somewhere?
It would be nice to have such documentation in kernel under
Documentation/$arch/HOW-TO-BUILD for every arch.
How much work is it to set-up an openembedded environment anyways?

Jan

-- 
http://l4x.org/k/

