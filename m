Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTFEVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbTFEVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:01:14 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:38106 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265121AbTFEU7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:59:45 -0400
Date: Thu, 5 Jun 2003 23:12:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, greg@kroah.com
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605211258.GA705@elf.ucw.cz>
References: <175110000.1054083891@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175110000.1054083891@w-hlinder>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I did this once before but due to some infrastructure changes 
> it had to be written again. Here it is, pretty simple. Now
> you can see your input devices (except keyboard) listed under
> /sys/class/input like this (yes, I do have two mice attached).
> At the moment the dev file is created and it contains the
> hex value of the major and minor number.

*very* nice, and urgently needed for suspend/resume support.

But should not structure be /bus/sys/keyboard_controller/mouse0? Mouse needs to be
suspended before keyboard controller...

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
