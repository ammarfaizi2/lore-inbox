Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUDFAVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbUDFAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:21:45 -0400
Received: from ibague.terra.com.br ([200.154.55.225]:17853 "EHLO
	ibague.terra.com.br") by vger.kernel.org with ESMTP id S263552AbUDFAVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:21:43 -0400
Subject: Re: 2.6.5 blank consoles (tty1-6)
From: Rafael Pereira <mosfet@phreaker.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200404042007.22998.jharrison@linuxbs.dyndns.org>
References: <200404042007.22998.jharrison@linuxbs.dyndns.org>
Content-Type: text/plain
Message-Id: <1081210905.11216.10.camel@flipflop.mosfet.bit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 21:21:45 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-04 at 21:07, Jason Harrison wrote:
> Greetings,
> 
> Today I upgraded from 2.6.4 to 2.6.5 using my config from 2.6.4.  I have all 
> the usual options set for text console such as CONFIG_INPUT=y, CONFIG_VT=y, 
> CONFIG_VGA_CONSOLE=y, CONFIG_VT_CONSOLE=y.  However in the 2.6.5 upgrade when 
> booting onto this new kernel all my text consoles from tty1-6 are all blank 
> after Uniform CD-ROM driver Revision: 3.20.  This is the last thing I see 
> before everything goes blank.  The next thing that pops up is the X server.
> 
> Any ideas why this is happening?
> 
> Thanks for your time and help.
> 
> Regards,
> Jason Harrison 

I saw it now. Try to enable this:

CONFIG_HW_CONSOLE=y

I think it's gonna work now.


Rafael.



-- 
Rafael Pereira - GNU/Linux Registered User #286151
Sign petition against software patents http://petition.eurolinux.org
Say NO to mono project
Be free. Use free software.

