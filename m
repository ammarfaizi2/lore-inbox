Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVAGA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVAGA2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVAGAZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:25:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56508 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261155AbVAGAXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:23:41 -0500
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Anton Mitterer <cam@mathematica.scientia.net>
Cc: Andrey Melnikoff <temnota+news@kmv.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DDC55B.2030106@mathematica.scientia.net>
References: <41D5D206.1040107@mathematica.scientia.net>
	 <1104676209.15004.58.camel@localhost.localdomain>
	 <e0qta2-7jr.ln1@kenga.kmv.ru>
	 <1105025417.17176.222.camel@localhost.localdomain>
	 <hcr0b2-ofr.ln1@kenga.kmv.ru>  <41DDC55B.2030106@mathematica.scientia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105053558.17176.297.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 23:19:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 23:10, Christoph Anton Mitterer wrote:
> What about the following idea?
> Both stay enabled by default but the help text explains exactly (as
> far as possible) which systems are affected.
> This would help newbies like me to decide if those bugfixes are
> necessary or not.

Its the ideal solution. The diff for this is available on your computer
already - its kept in /dev/null 8)

          The PC-Technologies RZ1000 IDE chip is used on many common 486
and
          Pentium motherboards, usually along with the "Neptune"
chipset.
          Unfortunately, it has a rather nasty design flaw that can
cause
          severe data corruption under many conditions. Say Y here to
include
          code which automatically detects and corrects the problem
under
          Linux. This may slow disk throughput by a few percent, but at
least
          things will operate 100% reliably.

          The CMD-Technologies CMD640 IDE chip is used on many common
486 and
          Pentium motherboards, usually in combination with a "Neptune"
or
          "SiS" chipset. Unfortunately, it has a number of rather nasty
          design flaws that can cause severe data corruption under many
common
          conditions. Say Y here to include code which tries to
automatically
          detect and correct the problems under Linux. This option also
          enables access to the secondary IDE ports in some CMD640 based
          systems.
                                                                                
  
