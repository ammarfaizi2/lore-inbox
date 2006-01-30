Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWA3Tc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWA3Tc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWA3Tc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:32:28 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:9451 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S964908AbWA3Tc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:32:27 -0500
Message-ID: <43DE6A06.9030707@shadowconnect.com>
Date: Mon, 30 Jan 2006 20:33:26 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] I2O: don't disable PCI device if it is enabled	before
 probing
References: <43D566DB.2010103@shadowconnect.com> <1138645069.31089.79.camel@localhost.localdomain>
In-Reply-To: <1138645069.31089.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:
> On Maw, 2006-01-24 at 00:29 +0100, Markus Lidel wrote:
>> Changes:
>> --------
>> - If PCI device is enabled before probing, it will not be disabled at
>>    exit.
> Looks ok for this case but be warned that pdev->is_enabled is not a safe
> check for many devices as the may be BIOS critical, or video for example
> but not in the Linux list of things _it_ enabled.

I've searched for a function enabled() or so, but didn't find anything. 
Could you tell me the right way to do it normally?

Thanks for the hint!

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
