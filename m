Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTGSN4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270080AbTGSN4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:56:32 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:37637 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S265182AbTGSN4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:56:32 -0400
Date: Sat, 19 Jul 2003 15:11:25 +0100
From: Alasdair G Kergon <agk@uk.sistina.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM/device mapper support for 2.6.0-test1?
Message-ID: <20030719151125.K31325@uk.sistina.com>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain> <20030718183027.A6328@uk.sistina.com> <Pine.LNX.4.53.0307190828570.4719@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.53.0307190828570.4719@localhost.localdomain>; from rpjday@mindspring.com on Sat, Jul 19, 2003 at 08:30:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 08:30:20AM -0400, Robert P. J. Day wrote:
> i just built (successfully, i think :-) LVM2 under 2.6.0-test1-ac2,
> and without testing it yet, i noticed that there is, in fact,
> a "pvmove" command.  does that mean that all the pvmove functionality
> is there now?  or what does it mean?

pvmove will only work with 2.4 kernels so far. 
It is still being ported to 2.6.

If you attempt to run pvmove on 2.6, it'll fail and you may need to run 
'pvmove --abort' to clean up the (failed) metadata changes.
 
Alasdair
-- 
agk@uk.sistina.com
