Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWJMQWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWJMQWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWJMQWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:22:14 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:64984 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751667AbWJMQWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:22:13 -0400
Date: Fri, 13 Oct 2006 18:22:10 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061013162210.GG3039@mail.muni.cz>
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com> <452F1142.3000400@intel.com> <20061013091608.GH18163@mail.muni.cz> <452FA451.6090702@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452FA451.6090702@intel.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 07:36:01AM -0700, Auke Kok wrote:
> >It's not an issue in the Linux kernel. Using various printk I can see that
> >tripple fault or reset via KBD is issued and followed by hang of the BIOS. 
> >
> >For i965 chipsets, the BIOS is *a lot* buggy :(
> 
> that's depressing, can you send me the output of `dmidecode` of the latest 
> BIOS? Perhaps I can reproduce it myself with that version.

Good news, as of kernel 2.6.19-rc1-git9, BIOS does *not* hang with both e1000 as
module or built in kernel.

The previous version of kernel was 2.6.18 which hangs the BIOS.

Aleksey:
are you sure that it is not the same in your case? Did you not switch kernel
version between e1000 as a module and built in kernel?

-- 
Luká¹ Hejtmánek
