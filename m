Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFCW57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFCW57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFCW57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:57:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:53982 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261172AbVFCW5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:57:48 -0400
Subject: Re: 2.6.12-rc5-git8 regression on PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Roland Dreier <roland@topspin.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050603182725.GB11355@otto>
References: <374360000.1117810369@[10.10.2.4]> <52is0vwd49.fsf@topspin.com>
	 <20050603182725.GB11355@otto>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 08:56:23 +1000
Message-Id: <1117839384.31082.186.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-03 at 13:27 -0500, Nathan Lynch wrote:
> Roland Dreier wrote:
> > I'm seeing something possibly related as well -- with an up-to-date
> > git tree (HEAD == d8d088d25822b0199fdfb392085e1cf8a5914a97), I get a
> > hang early in the boot on an OpenPower 710 (2 x POWER5).
> 
> Backing this one out fixes it here on a Power5 570.
> 
> http://marc.theaimsgroup.com/?l=bk-commits-head&m=111772917211270&q=raw
> 
> Ben, any ideas?

Weird, works fine on our POWER5 here. What is the output ? Especially,
what if you enable DEBUG_PROM in there ?

Ben.


