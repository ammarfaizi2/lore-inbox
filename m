Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSI3VaW>; Mon, 30 Sep 2002 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSI3VaW>; Mon, 30 Sep 2002 17:30:22 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:63639 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S261353AbSI3VaV>;
	Mon, 30 Sep 2002 17:30:21 -0400
Date: Mon, 30 Sep 2002 23:35:25 +0200
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Distributing drivers independent of the kernel source tree
Message-ID: <20020930213525.GB28556@h55p111.delphi.afb.lu.se>
References: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 04:55:07PM -0400, Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:
> 2. Assuming the kernel source is in /usr/src/linux is not always valid.
> 
> 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
> which is just as broken as method #2.
> 
> If no good method exists, would someone be willing to suggest a standard
> which would allow distribution of drivers separate from the kernel tree?

In projects that use autoconf (ie, have a large userspace app) some people
might find this useful:

http://0x63.nu/files/kern-autoconf/

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
