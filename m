Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUCJSFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUCJSFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:05:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:34217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262735AbUCJSD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:03:56 -0500
Date: Wed, 10 Mar 2004 10:02:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Godbole, Amarendra \(GE Consumer & Industrial\)" 
	<Amarendra.Godbole@ge.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
Message-Id: <20040310100215.1b707504.rddunlap@osdl.org>
In-Reply-To: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004 11:46:40 +0530 Godbole, Amarendra \(GE Consumer & Industrial\) wrote:

| Hi,
| 
| While writing code, the assignment operator (=) is many-a-times confused with the comparison operator (==) resulting in very subtle bugs difficult to track. To keep a check on this -- the constant can be written on the LHS rather than the RHS which will result in a compile time error if wrong operator is used.

Yes, we know.

| Is this an encouraged practice while writing any code for the kernel ? Or is this choice left to the developer ? I was unable to find any reference to it in the CodingStyle document. I did find some code under drivers/ which used (NULL == foo) and similar constructs. 

I prefer that it be left to each developer.

| Can this be added to the CodingStyle document ?

Hopefully not.  Some of us think that it's ugly.

BTW, can you use CR/LF every 70 characters or so, please?

--
~Randy
