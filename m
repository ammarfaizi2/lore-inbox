Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbUJ1LVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbUJ1LVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUJ1LUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:20:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26017 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262975AbUJ1LUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:20:06 -0400
Subject: Re: My thoughts on the "new development model"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <200410272159.29831.dtor_core@ameritech.net>
References: <200410271553_MC3-1-8D4F-38E7@compuserve.com>
	 <1098913229.7783.2.camel@localhost.localdomain>
	 <200410272159.29831.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098958603.9239.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Oct 2004 11:16:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-28 at 03:59, Dmitry Torokhov wrote:
> I really wonder why is it risky? 99% of the time USB is loaded eventually
> and does handoff anyway. What is the problem doing it earlier? Ones who
> indeed use USB in legacy mode will have to boot with "no-handoff". I think
> if you look at the numbers people using USB in legacy mode is a fraction
> of a percent.

The code to do the mode switches is non trivial, has to handle errata
and the like. If you compile in USB rather than having it modular then
it'll work out fine too which is another reason not to add a hack to -ac
when there is a safer fix 8)

