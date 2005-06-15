Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVFOAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVFOAPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFOAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:15:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVFOAPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:15:16 -0400
Date: Tue, 14 Jun 2005 17:16:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: christoph <christoph@scalex86.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-Id: <20050614171602.12bfa245.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506141704150.4225@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
	<20050608131839.GP23831@wotan.suse.de>
	<Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
	<20050614162354.6aabe57e.akpm@osdl.org>
	<Pine.LNX.4.62.0506141644160.4099@ScMPusgw>
	<20050614165818.6f83fa6c.akpm@osdl.org>
	<Pine.LNX.4.62.0506141704150.4225@ScMPusgw>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph <christoph@scalex86.org> wrote:
>
> On Tue, 14 Jun 2005, Andrew Morton wrote:
> 
> > > Yup that makes the whole thing much more sane. Can we specify multiple 
> > > attributes to a variable?
> > Seems OK?
> 
> Looks fine. Want a patch against the existing fixes in mm1? So that we 
> have a whatever-fix-fix-fix-fix-fix-fix-fix?

Let's see what it looks like.  Two patches please.  One againt the core
(optimise-storage-of-read-mostly-variables*.patch) and one against the
users (move-some-more-structures-into-mostly_readonly-and-readonly.patch).
