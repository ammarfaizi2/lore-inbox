Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbUCYXgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUCYXge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:36:34 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:51471 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263659AbUCYXgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:36:32 -0500
Date: Thu, 25 Mar 2004 16:35:46 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>, Kevin Corry <kevcorry@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1030470000.1080257746@aslan.btc.adaptec.com>
In-Reply-To: <40632804.1020101@pobox.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I respectfully disagree with the EMD folks that a userland approach is
> impossible, given all the failure scenarios.

I've never said that it was impossible, just unwise.  I believe
that a userland approach offers no benefit over allowing the kernel
to perform all meta-data operations.  The end result of such an
approach (given feature and robustness parity with the EMD solution)
is a larger resident side, code duplication, and more complicated
configuration/management interfaces.

--
Justin

