Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJ2Ofg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTJ2Off
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:35:35 -0500
Received: from mail1.neceur.com ([193.116.254.3]:3487 "EHLO mail1.neceur.com")
	by vger.kernel.org with ESMTP id S261397AbTJ2OfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:35:25 -0500
In-Reply-To: <3F9FCB1F.9080606@mcve.com>
To: Brad House <brad@mcve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OFD0D30073.3921A657-ON80256DCE.004EDE5F-80256DCE.0050215F@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Wed, 29 Oct 2003 14:35:14 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 02:35:15 PM,
	Serialize complete at 10/29/2003 02:35:15 PM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 02:35:15 PM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 02:35:15 PM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad,

My problem is one of the infamous nforce2 hardlockups.  You don't get any
kernel panic or anything that useful.  The system just locks up completely
and has to be manually reset.

The problem is known to associate with IDE activity and is thought (as far
as I know) to originate somewhere in the IDE driver.

Cheers,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."




Brad House <brad@mcve.com>
10/29/2003 02:13 PM
 
        To:     ross.alexander@uk.neceur.com
        cc:     Brad House <brad_mssw@gentoo.org>, 
linux-kernel@vger.kernel.org
        Subject:        Re: nforce2 stability on 2.6.0-test5 and 
2.6.0-test9


Hmm, interesting. The patches I submitted were strictly
for IDE/ATA133 improvements, apparently your problems don't
lie there.  I'd assume this was a kernel panic you had, any
output available that would tell you where it paniced ?

-Brad

ross.alexander@uk.neceur.com wrote:
> Brad,
> 
> I'm running an ASUS A7N8X Deluxe mobo (nforce2 chipset) and still
> getting hardlockups.  I applied your patch but my system still locked
> up after about a day.  However 2.6.0-test5 seems to be stable.  I have
> had my system up for over three weeks with APIC and ACPI turned on.
> 
> Just to let you know,
> 
> Ross
> 
> 
---------------------------------------------------------------------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 




