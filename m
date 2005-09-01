Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVIAI2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIAI2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVIAI2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:28:12 -0400
Received: from ns.firmix.at ([62.141.48.66]:60629 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750847AbVIAI2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:28:11 -0400
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
From: Bernd Petrovitsch <bernd@firmix.at>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <431651BC.9020108@utah-nac.org>
References: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net>
	 <431651BC.9020108@utah-nac.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 01 Sep 2005 10:28:06 +0200
Message-Id: <1125563286.28749.22.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 18:56 -0600, jmerkey wrote:
> Bernd Eckenfels wrote:
> >In article <20050901012218.02c79560.diegocg@gmail.com> you wrote:
> >>I mean, nvidia people also use propietary code in the kernel (probably
> >>violating the GPL anyway) and don't do such things.
> >
> >The Linux kernel allows binary drivers, you just have to live with a limited
> >number of exported symbols and that the kernel is tainted. Which basically
> >means nobody sane can help you with corrupted kernel data structures.
[...]
> Thanks for the accurate and reasonable response.  I object to the use of 
> the word "tainted".  This implies the
> binary code is somehow infringing.  I would suggest changing the word to 

It is infringing the debuggability seriously outside the exclusive club
of people with access to the secret source of these drivers.
So "tainted" pretty much explains quite well the situation as seen from
the kernel side.

> "non-GPL" or "Vendor Supported" since
> this is more accurate.   Just a suggestion.

"non-GPL" is clearly wrong. First the kernel source it self stays GPL
independent for whatever legal people write into othre license
agreements, second the license of your source *could be* (in theory) GPL
if the authors wanted it and - in some cases - the source *is* actually
GPL even if the authors doesn't want it.
And "Vendor supported" must be (if you really want to be accurate) "At
best it is vendor supported if the vendor exists at the moment and for
whatever said vendor thinks support is. The contact address for said
vendor is <name>, <street>, <phnoe>, <mobile>, <email>, <homepage>.
Please do not ask the free software community if you have any problem
with the Linux kernel."
So please put this in your proprietory module and print it whenever it
makes sense since the necessary contact data is only known by you.
The point is: There is no such concept as "vendor" as it would or could
be seen in the commercial and/or legal world if you download the kernel
source from kernel.org.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

