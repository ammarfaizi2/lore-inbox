Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTAUSm0>; Tue, 21 Jan 2003 13:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbTAUSm0>; Tue, 21 Jan 2003 13:42:26 -0500
Received: from fmr02.intel.com ([192.55.52.25]:16868 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267162AbTAUSmZ>; Tue, 21 Jan 2003 13:42:25 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A12B@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Cc: acpi-devel@sourceforge.net, mingo@redhat.com
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 10:36:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin J. Bligh [mailto:mbligh@aracnet.com] 

> Would be a lot easier to read if you could seperate out the
> renames from the rest of the patch that actually does things.
> It all makes me slightly nervous as this stuff is really easy
> to break ... and it breaks wierd machines that are hard to test
> for (been there, done that ;-)).

Exactly why I wanted to clean up the code - too fragile! :)

Anyways, I will take a stab at redoing the changesets the way you
describe.

> +static u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = 
> BAD_APICID };
> 
> Looks odd. May have merged forward badly, that got renamed in 2.5.59
> to bios_cpu_apicid or something. 

You are right. I'll fix that.

> Anyway, I'll give it a spin on my wierdo box, and see what happens.

Cool, thanks.

Regards -- Andy
