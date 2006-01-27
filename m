Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWA0O21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWA0O21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWA0O21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:28:27 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:4584 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1751048AbWA0O21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:28:27 -0500
Mime-Version: 1.0 (Apple Message framework v623)
Content-Transfer-Encoding: 7bit
Message-Id: <a76b68304d1cadc77190142ba67324a6@cs.pitt.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: "Lorne J. Leitman" <leitman@cs.pitt.edu>
Subject: re: patching arm-linux 2.4.18 on sharp zaurus sl-5500
Date: Fri, 27 Jan 2006 09:28:07 -0500
X-Mailer: Apple Mail (2.623)
X-Spam-Score: -101.665/8 BAYES_00,USER_IN_WHITELIST SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Apologies in advance if this is appearing on an inappropriate list!

We are a group of researchers at University of Pittbsurgh trying to
implement an ad-hoc routing protocol on the Sharp Zaurus 5500 pda.  Our
network is running the following environment:
       -arm-linux kernel 2.4.18-pxa3-embedix-021129
       -OpenZaurus 3.5.1

The protocol has been implemented on laptops already, running normal 
Linux
OS.  Now we want to port it to embedix for the PDA's but we are having
some trouble.

In order to begin our implementation on the PDA's, we need to make use 
of
Linux real-time timers.  These are part of the POSIX.1b standard, and 
are
supposedly present already in the 2.4 kernel.  However, they do not seem
to be present in 2.4.18 embedix kernel.  Does anyone know of a patch or
module that we can apply to this kernel so we can take advantage of 
these
timers?

We also need to leverage the Netfilter portion of the kernel.  Again,
netfilter should be part of the 2.4 kernel.  There does appear to be an
"kernel-module-ip-tables"  installed, but there is no iptables binary in
the userspace.  Does anyone know how we can get hold of iptables for
arm-linux?

thanks very much!

--Lorne

