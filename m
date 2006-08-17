Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWHQXQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWHQXQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWHQXP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:15:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24517 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965150AbWHQXP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:15:59 -0400
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
From: john stultz <johnstul@us.ibm.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060817224448.GB3616@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060817224448.GB3616@aitel.hist.no>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 16:15:50 -0700
Message-Id: <1155856550.31755.142.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 00:44 +0200, Helge Hafting wrote:
> I got 2.6.18-rc4-mm1 going, and it appears that system 
> moves at about 3x normal speed.  A software clock need 3
> seconds to advance 10 seconds, for example.
> 
> Everything else seems faster too, the keyboard autorepeat,
> delay loops in games, and so on.  
> 
> Guess I could live with this, if it'd also compile
> 3x faster. :-/
> 
> This is a x86-64 kernel, with the jiffies hotfix applied.

Sounds like the same issue Gregorie Favre is dealing with.

Please send full dmesg output.

Does 2.6.18-rc4, or 2.6.18-rc3-mm2 have this issue?

thanks
-john


