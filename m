Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbTDBRzF>; Wed, 2 Apr 2003 12:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTDBRzF>; Wed, 2 Apr 2003 12:55:05 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:6930 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S263077AbTDBRzD>; Wed, 2 Apr 2003 12:55:03 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200304021806.h32I6M709795@mako.theneteffect.com>
Subject: Re: subsystem crashes reboot system?
To: rmiller@duskglow.com (Russell Miller)
Date: Wed, 2 Apr 2003 12:06:22 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200304021149.36511.rmiller@duskglow.com> from "Russell Miller" at Apr 02, 2003 11:49:36 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> good.  But this crash left the system in a semi-functional state.  The 
> networking stack was up and running, the kernel was running, but the 
> filesystem was not functional and because of this the kernel was in a nearly 
> unusable state.  Because the system was pingable, most tcp-stack level 
> detectors would not have been able to tell that something serious was wrong.  
> The machine (our main production machine that serves millions of hits a week) 
> was down for three hours.

Isn't this what watchdog is for?  I think even the software watchdog would
catch this, then you can panic and reboot.

	M
