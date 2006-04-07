Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWDGUnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWDGUnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWDGUnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:43:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33436 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964944AbWDGUnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:43:51 -0400
Date: Fri, 7 Apr 2006 22:43:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] generic clocksource updates
In-Reply-To: <1144351944.5925.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604072239110.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home> 
 <1144317972.5344.681.camel@localhost.localdomain>  <Pine.LNX.4.64.0604062048130.17704@scrub.home>
 <1144351944.5925.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Apr 2006, Thomas Gleixner wrote:

> > Currently this field isn't needed and as soon we have a need for it, we 
> > can add proper capability information.
> 
> Is there a reason, why requirements which are known from existing
> experience must be discarded to be reintroduced later ?

Then please explain these requirements.
This field shouldn't have been added in first place, I guess I managed to 
confuse John when I talked about handling of continuous vs. tick based 
clocks. Currently no user should even care about this, it's an 
implementation detail of the clock.

bye, Roman
