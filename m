Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFHJEn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 05:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFHJEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 05:04:43 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:45498 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S261222AbTFHJEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 05:04:42 -0400
Date: Sun, 8 Jun 2003 11:18:06 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Support for mach-xbox
Message-ID: <20030608091806.GB1702@h55p111.delphi.afb.lu.se>
References: <20030602202714.GD18786@h55p111.delphi.afb.lu.se> <20030606145651.GB4960@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606145651.GB4960@zaurus.ucw.cz>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19OwJS-0000X3-00*eN2Df112lRQ*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 04:56:52PM +0200, Pavel Machek wrote:
> Hi,
> 
> > Attached is a patch that adds a new subachitecture for the xbox gaming
> 
> Why does xbox need new subarchitecture?
> It should be normal PC...

It need to blacklist some pci-devices, if you touch them it hangs. And it
has different CLOCK_TICK_RATE. So booting an xbox-kernel on other PC's will
make the blacklisted pci-devices disappear, and you will get wrong
CLOCK_TICK_RATE. It also has different restart/shutdown code. 

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
