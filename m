Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWE0UcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWE0UcD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWE0UcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:32:03 -0400
Received: from sd291.sivit.org ([194.146.225.122]:55049 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S964924AbWE0UcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:32:02 -0400
Subject: Re: [PATCH] make ams work with latest kernels
From: Stelian Pop <stelian@popies.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148760414.16989.59.camel@johannes.berg>
References: <1148383943.25971.2.camel@johannes>
	 <1148465069.6723.26.camel@localhost.localdomain>
	 <20060526173908.GA3357@ucw.cz>  <1148760414.16989.59.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 27 May 2006 22:31:58 +0200
Message-Id: <1148761919.3132.1.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 27 mai 2006 à 22:06 +0200, Johannes Berg a écrit :
> On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:
> 
> > > This driver also provides an absolute input class device, allowing
> > > the laptop to act as a pinball machine-esque joystick.
> > 
> > Is it useful to have /sysfs interface when we already have same data
> > available as joystick?
> 
> Might be useful if you need to turn off the "joystick" because X gets
> confused with it. Other than that, no.

/sysfs interface also exports the 'z' coordinate, the input interface
does not.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

