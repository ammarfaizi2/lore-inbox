Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWABT4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWABT4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWABT4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:56:17 -0500
Received: from mxsf10.cluster1.charter.net ([209.225.28.210]:60634 "EHLO
	mxsf10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750994AbWABT4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:56:16 -0500
X-IronPort-AV: i="3.99,322,1131339600"; 
   d="scan'208"; a="1977235543:sNHT30422494"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17337.34143.675341.20808@smtp.charter.net>
Date: Mon, 2 Jan 2006 14:56:15 -0500
From: "John Stoffel" <john@stoffel.org>
To: "Puvvada, Vijay B." <vijay.b.puvvada@saic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Make system and linking static libraries on kernel version
	s2.6.14+
In-Reply-To: <1136213489.3483.18.camel@hadji>
References: <1136213489.3483.18.camel@hadji>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vijay> In a nutshell, I am trying to compile the Nortel VPN client
Vijay> (which is written as part driver and part app) against the
Vijay> 2.6.14 kernel and I am getting the following warning.

This software is from a company called 'Apani Networks' and they are
slow to update their code to reflect kernel changes.  I too am stuck
with Nortal VPN boxes at work and it's a pain to get them working.
What's worse, is their NetLock software is also a pain to get working
as well...

Try dropping back to the latest kernel they have supported in their
library and compile that.  I was certainly able to make it compile
against 2.6.12 as I recall... but since I was running 2.6.13+ at the
time, it didn't do me much good...

Again, double check the README that came with the software and try to
do all the compile work by hand, and not using their canned solutions
for Redhat, etc.  I was able to get it to compile, but never managed
to get it working on my main home machine unfortunately.  

Can you post the log of all the steps you took to compile the code,
the kernel version you're using, and any output of the make commands?
That would help.

John
