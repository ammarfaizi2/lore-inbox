Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWDUTVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWDUTVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDUTVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:21:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13800 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932145AbWDUTVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:21:09 -0400
Date: Fri, 21 Apr 2006 21:20:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: luming.yu@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: acpi hotkey sysfs support
Message-ID: <20060421192040.GA3161@elf.ucw.cz>
References: <20060419130719.GA2599@ucw.cz> <20060421191632.GF2078@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421191632.GF2078@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > I have created a place under sysfs to have a unified place
> > to gather user input for common hotkey features. 
> > http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
> > 
> > All of you are owner of a specific acpi hotkey driver. 
> > Would you like to use that sysfs support to reduce the
> > unnecessary interface complexity.
> 
> Yep, patch looks okay. It would be nice to format it linux-like,
> through. Space between if and (, and such stuff.
> 
> SHOUTING_TYPEDEFS look bad to me, too.

One more thing... can we use input api for these events? Routing
buttons through /proc/acpi/event was mistake from day 0 :-(.

							Pavel

-- 
Thanks for all the (sleeping) penguins.
