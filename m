Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbSLEWUR>; Thu, 5 Dec 2002 17:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbSLEWUR>; Thu, 5 Dec 2002 17:20:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267534AbSLEWUQ>;
	Thu, 5 Dec 2002 17:20:16 -0500
Message-ID: <3DEFD2CE.4070805@pobox.com>
Date: Thu, 05 Dec 2002 17:27:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Eric Altendorf <EricAltendorf@orst.edu>, Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.grover@intel.com
Subject: Re: [2.5.50, ACPI] link error
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <3DEFD17D.4090809@pobox.com> <20021205222431.GB7396@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021205222431.GB7396@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Yes, there are about 10 patches to fix it floating around... I just
> hope linus takes one of them. (Fix is make ACPI_SLEEP depend on
> swsusp).


I haven't seen the patch, but does it make sense for hardware suspend to 
depend on software suspend?

IMO there should be a common core (CONFIG_SUSPEND?), not force ACPI to 
depend on swsusp.  That way you get the _least_ common denominator, not 
the union of two sets.

	Jeff



