Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTLCLtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 06:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTLCLtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 06:49:08 -0500
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:30930 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264547AbTLCLtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 06:49:06 -0500
Date: Wed, 3 Dec 2003 22:54:04 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031203115404.GE1810@gnu.org>
References: <20031203110510.GC1810@gnu.org> <Pine.LNX.4.21.0312031224050.28298-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0312031224050.28298-100000@mlf.linux.rulez.org>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 12:28:20PM +0100, Szakacsits Szabolcs wrote:
> > The real question is: "what is the default install option - LBA or CHS
> > - on modern(ish) Windows systems?"
> 
> Autodetect unless it's explicitely set.

Can you elaborate?  Autodetect what?  Autodetect if the BIOS supports LBA?

(BTW, "LBA mode" is purely setting CHS = x/255/63, right?
It's not like anything is getting enabled/disabled?)

> > What proportion of XP users boot via CHS?
> 
> Depends on BIOS, boot manager, configuration, etc.

Sure.  But can we estimate anyway?  Do a "random" survey?

* does more than 1% of the Windows market use a boot manager other
than Windows'/lilo/grub?  (Guess: No)

* what proportion of Windows users do any configuration themselves?
What about the OEM installers?  (Aren't these a high proportion?) 
(Guess: 90% OEM; 1% of users do boot config)

* do OEM installers generally use LBA?  (Guess: no idea)

Maybe the students/academics here should poke around their university
campuses.  I'm not sure how we could unobtrusively check!  Some BIOS
POST screens show useful info.

Cheers,
Andrew

