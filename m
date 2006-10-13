Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWJMVlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJMVlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJMVlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:41:53 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:61876 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030183AbWJMVlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:41:52 -0400
Date: Fri, 13 Oct 2006 23:41:45 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061013214145.GJ3039@mail.muni.cz>
References: <20061013162210.GG3039@mail.muni.cz> <20061013202224.95503.qmail@web83115.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061013202224.95503.qmail@web83115.mail.mud.yahoo.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 01:22:24PM -0700, Aleksey Gorelov wrote:
> > Good news, as of kernel 2.6.19-rc1-git9, BIOS does *not* hang with both e1000 as
> > module or built in kernel.
> > 
> > The previous version of kernel was 2.6.18 which hangs the BIOS.
> > 
> > Aleksey:
> > are you sure that it is not the same in your case? Did you not switch kernel
> > version between e1000 as a module and built in kernel?
> 
> As far as I understand, you've udpated the whole kernel, not just the
> driver. I've tried using  driver from 2.6.19-rc2 as well as v7.2.9 from 
> Intel's website - same story - still no reboot. Did you try just updating 
> driver (without whole kernel) ? 

I've rechecked behaviour of e1000 driver. For me, it looks like this:

2.6.18 (vanilla): e1000 as a module - system reboots OK.
                  e1000 built in    - system hangs after KBD reset or tripple
		                      fault

2.6.19-rc1-git9 (vanilla): e1000 as a module - system reboots OK.
                           e1000 built in    - system reboots OK.

-- 
Luká¹ Hejtmánek
