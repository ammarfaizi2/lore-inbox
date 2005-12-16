Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVLPW60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVLPW60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVLPW6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:58:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:56201 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964817AbVLPW6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:58:25 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: G.Ohrner@post.rwth-aachen.de, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1134736325.13138.119.camel@localhost.localdomain>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134736325.13138.119.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 14:58:22 -0800
Message-Id: <1134773902.27117.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 07:32 -0500, Steven Rostedt wrote:
> I'll look into your oops later (or maybe Ingo has some time), but I've
> also notice the slowness of 2.6.15-rc5-rt2, and I'm investigating it
> now.

Hey Steven,
	Do check that the slowness you're seeing isn't related to the
CONFIG_PARANIOD_GENERIC_TIME option being enabled. It is expected that
the extra checks made by that config option would slow things down a
bit.

thanks
-john

