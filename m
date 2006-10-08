Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWJHXoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWJHXoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWJHXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:44:33 -0400
Received: from gw.goop.org ([64.81.55.164]:705 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932108AbWJHXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:44:33 -0400
Message-ID: <45298D65.8090503@goop.org>
Date: Sun, 08 Oct 2006 16:44:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061007214620.GB8810@stusta.de> <20061008071254.GA5672@ucw.cz>
In-Reply-To: <20061008071254.GA5672@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Strange, problem went away after reboot. I guess I'll write it off as
> an acpi glitch... there's definitely something strange going on with
> backlight around s2ram: during normal operation, backlight changes are
> fast. After s2ram, backlight change from keyboard takes 300msec or so.
>   

Yes, I'm seeing that too.  It's not just keyboard brightness changes; 
gnome does some fadeup effect, which takes ~300ms/step as well.

    J

