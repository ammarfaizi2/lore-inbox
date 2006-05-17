Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWEQMsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWEQMsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEQMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:48:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:16586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932546AbWEQMs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:48:29 -0400
X-Authenticated: #13243522
Message-ID: <446B1B9C.5090003@gmx.de>
Date: Wed, 17 May 2006 14:48:28 +0200
From: Michael Schierl <schierlm@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: "zhao, forrest" <forrest.zhao@intel.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: AHCI suspend works for me! (was: [ANNOUNCE] libata: new EH, NCQ,
 hotplug and PM patches against stable kernel)
References: <20060512132437.GB4219@htj.dyndns.org>	 <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>	 <4469EC4A.30908@gmx.de> <1147829339.7273.97.camel@forrest26.sh.intel.com>
In-Reply-To: <1147829339.7273.97.camel@forrest26.sh.intel.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=58B48CDD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhao, forrest schrieb:
>> And - what SATA ACPI patches?
>>
>> I have quite alot of patches related to sata and/or acpi (collected from
>> different mailing lists) here on hard disk but don't know which ones are
>> broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...
>>
>> If more recent patches are only available via git, I'd need some good
>> GIT tutorial first...
>>
>> TIA, and sorry for stealing your time,
>>
>> Michael
> Michael,
> 
> I ported a patch from OpenSUSE for AHCI suspend/resume. You may find the
> patch at:
> y

I cannot see any patch in this mail...

However, the patch linked there "indirectly",

http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch

applies well on vanilla 2.6.16 (although not on top of the "new EH"
patch) and is the first one that really works (as far as I tested it).

I tested it on a minimal kernel (no network no sound no nothing); I'll
build a new "non-minimal" kernel now :) If I run into any problems; I'll
tell you.

Thank you.

Michael
