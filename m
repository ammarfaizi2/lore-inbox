Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTDHPUm (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTDHPUm (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:20:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261841AbTDHPUl (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:20:41 -0400
Date: Tue, 8 Apr 2003 08:31:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm1
Message-Id: <20030408083153.5dec0d0e.rddunlap@osdl.org>
In-Reply-To: <200304080917.15648.tomlins@cam.org>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<200304080917.15648.tomlins@cam.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 09:17:15 -0400 Ed Tomlinson <tomlins@cam.org> wrote:

| Hi,
| 
| This does not boot here.  I loop with the following message. 
| 
| i8042.c: Can't get irq 12 for AUX, unregistering the port.
| 
| irq 12 is used (correctly) by my 20267 ide card.  My mouse is
| usb and AUX is not used.
| 
| Ideas?

I guess that's due to my early kbd init patch.
So why do you have i8042 configured into your kernel?

The loop doesn't terminate?  Do you get the same message (above)
over and over again?

--
~Randy
