Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEQQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTEQQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 12:26:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57984 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261651AbTEQQ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 12:26:47 -0400
Subject: Re: time interpolation hooks
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@napali.hpl.hp.com>
In-Reply-To: <1053189093.27770.12.camel@laptop.cornchips.homelinux.net>
References: <20030516142311.3844ee97.akpm@digeo.com>
	 <1053189093.27770.12.camel@laptop.cornchips.homelinux.net>
Content-Type: text/plain
Organization: 
Message-Id: <1053189420.27771.15.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 May 2003 09:37:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 09:31, john stultz wrote:
> On Fri, 2003-05-16 at 14:23, Andrew Morton wrote:
> > Gents, the below patch comes from David M-T, out of the ia64 tree.  It may
> > be a suitable solution to the "gettimeofday goes backwards when interrupts
> > were blocked" problem.
> > 
> > It will need per-arch support.  I'm not sure what that looks like; maybe
> > David can outline what the reset/update functions should do?
> 
> Yea, I'd like to see a sample reset/update implementation as well. 


Doh, David I just saw your email providing these. Thanks
-john


