Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTIOTOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIOTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:14:33 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:55451 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261329AbTIOTOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:14:32 -0400
Subject: Re: Need fixing of a rebooting system
From: Chris Meadors <clubneon@hereintown.net>
To: mrproper@ximian.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1063650478.1516.0.camel@localhost.localdomain>
References: <1063496544.3164.2.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
	 <3F6450D7.7020906@ximian.com>
	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>
	 <1063561687.10874.0.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>
	 <3F64FEAF.1070601@ximian.com>
	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
	 <1063650478.1516.0.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1063653132.224.32.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Sep 2003 15:12:13 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19yynw-0000m7-44*VJgcYDhe3dU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 14:27, Kevin Breit wrote:

> I disabled ACPI and that didn't help.  I reenabled it now and I'm
> looking for other options to disable.  But I don't know where to start. 
> Any suggestions?

What CPU are you running on?  It isn't an Opteron is it?  I saw the same
thing with the NUMA support for the AMD64.

Use "make menuconfig" and have a look at all the options under the first
few menus.  Make sure your CPU and power management options look right
for your machine.  When in doubt read the help text for the option, it
is sometimes very helpful.

-- 
Chris

