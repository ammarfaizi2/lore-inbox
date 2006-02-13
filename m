Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWBMT0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWBMT0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWBMT0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:26:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:15759 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932418AbWBMT0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:26:01 -0500
Subject: Re: [PATCH 04/13] hrtimer: remove nsec_t
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1139837090.2480.475.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0602130209590.23812@scrub.home>
	 <1139837090.2480.475.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 11:25:58 -0800
Message-Id: <1139858758.28536.52.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 14:24 +0100, Thomas Gleixner wrote:
> On Mon, 2006-02-13 at 02:10 +0100, Roman Zippel wrote:
> > nsec_t predates ktime_t and has mostly been superseded by it. In the few
> > places that are left it's better to make it explicit that we're dealing
> > with 64 bit values here.
> > 
> > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>


Sounds like a fair enough argument for me.

Acked-by: John Stultz <johnstul@us.ibm.com>


Andrew: From the mm-commits it looks like you've already merged the TOD
bits for this patch. I'll merge those changes in my tree as well. Please
let me know if any issues crop up and I can send updated patches. 

thanks
-john


