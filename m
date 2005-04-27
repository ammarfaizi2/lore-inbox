Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVD0So5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVD0So5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVD0Sna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:43:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:51629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261938AbVD0SnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:43:12 -0400
Date: Wed, 27 Apr 2005 11:42:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: tab@snarc.org, ak@suse.de, linux-kernel@vger.kernel.org,
       ian.pratt@cl.cam.ac.uk
Subject: Re: [PATCH 5/6][XEN][x86_64] Add macro for debugreg
Message-Id: <20050427114238.4e97f03d.akpm@osdl.org>
In-Reply-To: <20050427130459.GI13305@wotan.suse.de>
References: <20050426113149.GE26614@snarc.org>
	<20050426131707.GB5098@wotan.suse.de>
	<20050426152638.GA23714@snarc.org>
	<20050427130459.GI13305@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Tue, Apr 26, 2005 at 05:26:38PM +0200, Vincent Hanquez wrote:
> > On Tue, Apr 26, 2005 at 03:17:07PM +0200, Andi Kleen wrote:
> > > It looks good, except that the name of the macro is too long.
> > > I will queue it and fix the name up when I apply. 
> > 
> > fine. let me know the new name, I'll regenerate a new set of patch for
> > x86 too. It's probably better to have the same name between the 2 archs.
> 
> Just dropping the cpu_ should be enough.

I've edited the six diffs to remove the cpu_.
