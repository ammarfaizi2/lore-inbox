Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVCCLtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVCCLtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVCCLME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:12:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42654 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261587AbVCCK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:59:49 -0500
Message-ID: <4226EE0F.1050405@pobox.com>
Date: Thu, 03 Mar 2005 05:59:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<20050302230634.A29815@flint.arm.linux.org.uk>	<42265023.20804@pobox.com>	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>	<20050303002047.GA10434@kroah.com>	<Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>	<20050303081958.GA29524@kroah.com>	<4226CCFE.2090506@pobox.com>	<20050303090106.GC29955@kroah.com>	<4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org>
In-Reply-To: <20050303021506.137ce222.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than mixing problem and solution, let me just define the two 
problems in this thread:


1) There is no clear, CONSISTENT point where "bugfixes only" begins. 
Right now, it could be -rc2, -rc3, -rc4... who knows.

We need to send a clear signal to users "this is when you can really 
start hammering it."  A signal that does not change from release to 
release.  A signal that does not require intimate knowledge of the 
kernel devel process.

This is a key reason why we don't get more pre-release testing.


2) After 2.6.11 release is out, there is no established process for "oh 
shit, 2.6.11 users will really want that fixed."


--------------------


Linus's even/odd proposal is an example of a solution for problem #2, as 
is my 2.6.X.Y proposal.

The 2.4.x series -pre/-rc is an example of a solution for problem #1.

	Jeff



