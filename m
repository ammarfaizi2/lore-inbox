Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbSLEWbA>; Thu, 5 Dec 2002 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267561AbSLEWbA>; Thu, 5 Dec 2002 17:31:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267560AbSLEWa6>;
	Thu, 5 Dec 2002 17:30:58 -0500
Message-ID: <3DEFD54A.8050306@pobox.com>
Date: Thu, 05 Dec 2002 17:38:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <3DEFD17D.4090809@pobox.com> <20021205222431.GB7396@atrey.karlin.mff.cuni.cz> <3DEFD2CE.4070805@pobox.com> <20021205223353.GE7396@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021205223353.GE7396@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>Yes, there are about 10 patches to fix it floating around... I just
>>>hope linus takes one of them. (Fix is make ACPI_SLEEP depend on
>>>swsusp).
>>
>>
>>I haven't seen the patch, but does it make sense for hardware suspend to 
>>depend on software suspend?
>>
>>IMO there should be a common core (CONFIG_SUSPEND?), not force ACPI to 
>>depend on swsusp.  That way you get the _least_ common denominator, not 
>>the union of two sets.
> 
> 
> Feel free to fix that, but as swsusp is needed for S4, anyway, I do not
> see big need to do that.


Why should I fix your fix?

Doesn't that imply your fix is broken to begin with?

