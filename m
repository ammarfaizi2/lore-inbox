Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLUFp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLUFp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVLUFp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:45:29 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:12944 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932129AbVLUFp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:45:28 -0500
Date: Wed, 21 Dec 2005 06:45:19 +0100
From: Voluspa <lista1@telia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc6
Message-Id: <20051221064519.6ffb0315.lista1@telia.com>
In-Reply-To: <Pine.LNX.4.64.0512202131000.4827@g5.osdl.org>
References: <20051221052101.1acb6cc4.lista1@telia.com>
	<Pine.LNX.4.64.0512202131000.4827@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 21:33:28 -0800 (PST) Linus Torvalds wrote:
[...]
> > 2203d6ed448ff3b777ee6bb614a53e686b483e5b:
> >
> >     Fix ACPI processor power block initialization
> 
> I'd love to have it fixed, but quite frankly, if the choice is between a 
> boot-time lockup and not using ACPI C1 sleep states, I'll take the 
> non-working sleep states.
> 
> The code in question had comments that didn't match what it was doing, and 
> apparently the ACPI guys couldn't say what was wrong..
> 
> But it might make sense to open a bugzilla entry so that it doesn't get 
> lost.

No sweat, it's easy to revert locally. I'll open a report once I've registered
at the bugzilla.

God Jul (och se upp med revbenen!)
Mats Johannesson
--
