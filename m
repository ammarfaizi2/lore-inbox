Return-Path: <linux-kernel-owner+w=401wt.eu-S1759285AbWLIHcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759285AbWLIHcR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 02:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759291AbWLIHcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 02:32:17 -0500
Received: from gw.goop.org ([64.81.55.164]:35633 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759285AbWLIHcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 02:32:16 -0500
Message-ID: <457A667E.5060608@goop.org>
Date: Fri, 08 Dec 2006 23:32:14 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Judith Lebzelter <judith@osdl.org>
Subject: Re: PPC compiler error (redefinition of 'struct bug_entry')
References: <Pine.SOC.4.61.0612082059360.16172@math.ut.ee> <4579CD80.1040302@goop.org> <Pine.SOC.4.61.0612090728510.14163@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0612090728510.14163@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>> Hm, what's your .config?
>>     
>
> Below. It's a PReP machine so using the old ppc arch.
>
>   
>> Hey, what's arch/pps/include/asm/bug.h?  Is your tree clean?
>>     
>
> Tree is clean

So why don't I have arch/ppc/include/asm/bug.h in my tree here?

It does look like the patch which converted ppc to use the generic bug
stuff did not remove any of the ppc-specific definitions though.  Did
some part of the patch get lost?

    J
