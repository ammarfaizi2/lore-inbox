Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945957AbWJZWIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945957AbWJZWIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWJZWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:08:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:60387 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1945957AbWJZWIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:08:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.18-rt7] BUG: time warp detected!
Date: Fri, 27 Oct 2006 00:07:35 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
References: <1161847210.32585.14.camel@Homer.simpson.net>
In-Reply-To: <1161847210.32585.14.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610270007.36648.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 26 October 2006 09:20, Mike Galbraith wrote:
> Greetings,
> 
> $subject happened on my single P4/HT box sometime after resume from
> disk.  Hohum activity:  I had just read lkml and was retrieving latest
> glibc snapshot when I noticed the trace.  I also noticed that the kernel
> decided to use pit instead of tsc.

Please check if CONFIG_PM_TRACE is not set in your .config.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
