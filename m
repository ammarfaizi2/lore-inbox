Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRCWLru>; Fri, 23 Mar 2001 06:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130683AbRCWLra>; Fri, 23 Mar 2001 06:47:30 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130618AbRCWLrU>;
	Fri, 23 Mar 2001 06:47:20 -0500
Message-ID: <20010323002927.C126@bug.ucw.cz>
Date: Fri, 23 Mar 2001 00:29:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Woller, Thomas" <twoller@crystal.cirrus.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F06D@csexchange.crystal.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F06D@csexchange.crystal.cirrus.com>; from Woller, Thomas on Thu, Mar 22, 2001 at 02:29:48PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Problem: Certain Laptops (IBM Thinkpads is where i see the issue) reduce the
> CPU frequency based upon whether the unit is on battery power or direct
> power.  When the Linux kernel boots up, then the cpu_khz (time.c)

This is issue with my toshiba sattelite, too. I even had a patch to
detect that speed changed and recalibrate (see archives), but
recalibrate may come too late.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
