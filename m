Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbSLKKG6>; Wed, 11 Dec 2002 05:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSLKKG6>; Wed, 11 Dec 2002 05:06:58 -0500
Received: from poup.poupinou.org ([195.101.94.96]:20524 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267101AbSLKKG5>; Wed, 11 Dec 2002 05:06:57 -0500
Date: Wed, 11 Dec 2002 11:14:38 +0100
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021211101438.GC29390@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com> <1039481341.12046.21.camel@irongate.swansea.linux.org.uk> <20021210204031.GF20049@atrey.karlin.mff.cuni.cz> <23440000.1039553448@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23440000.1039553448@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 09:50:48AM +1300, Andrew McGregor wrote:
> I strongly suspect that s4bios will work on this machine, but swsusp won't. 
> Why?  It's a Dell Inspiron 8000 with an NVidia Geforce2go, and until NVidia 
> put pm support in their driver, it's game over for Linux.  Except that the 
> BIOS knows how to suspend it, so some kernel/driver combinations work with 
> APM.  I suspect any Geforce2go Dell is the same.

No.  You are wrong.  I need to suspend allmost all the drivers, and the
video chipset is not an execption (or go to a console before suspending,
in fact).
You still need to bug NVIDIA in order to have proper pm support
in their driver.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
