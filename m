Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUJRUkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUJRUkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUJRUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:37:25 -0400
Received: from [69.4.201.55] ([69.4.201.55]:19600 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S266460AbUJRUfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:35:03 -0400
Message-ID: <417428F2.2050402@bitworks.com>
Date: Mon, 18 Oct 2004 15:34:58 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
References: <200410160946.32644.adaplas@hotpop.com> <4173B865.26539.117B09BD@localhost>
In-Reply-To: <4173B865.26539.117B09BD@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> 
> I would assume however a serial port console would be fine for embedded 
> machines until the framebuffer driver could come up anyway.
> 
This would be an incorrect assumption.  Speaking as a developer of one 
said embedded system I must have video at boot and be able to dump 
critical kernel messages to the screen.

In the field, hooking up a serial cable to see why the unit doesn't boot 
requires the dispatch of a tech who would have open up the unit to get 
to the serial port.  This costs the end client lots of $$.  They don't 
like that.

By having video on boot the support person can tell the end user to look 
at the screen and read back any messages and then make the determination 
  if a tech dispatch is needed.

And its common practice to only have as many serial ports as the system 
needs during runtime.  During development you can dual purpose them but 
in the final system their may not be a serial port free (or even 
installed) to get that console info from.

-- 
Richard A. Smith


