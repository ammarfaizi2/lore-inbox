Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276989AbRJCVeG>; Wed, 3 Oct 2001 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276997AbRJCVd4>; Wed, 3 Oct 2001 17:33:56 -0400
Received: from cs.columbia.edu ([128.59.16.20]:50338 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S276994AbRJCVdl>;
	Wed, 3 Oct 2001 17:33:41 -0400
Date: Wed, 3 Oct 2001 17:34:10 -0400
Message-Id: <200110032134.f93LYAd08956@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jdthood@home.dhs.org (Thomas Hood)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011003153550.0A0D85AC@thanatos.toad.net>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001 11:35:50 -0400 (EDT), Thomas Hood <jdthood@home.dhs.org> wrote:

> I notice that both the Vaio and the Inspiron have Phoenix BIOSes.
> So perhaps there is a class of Phoenix BIOSes we should be testing
> for.  For the time being, we will need to add Ion Badulescu's Inspiron
> to the dmi_blacklist.  Ion, can you give us the exact product name,
> exact BIOS vendor name, exact BIOS version and exact BIOS date?
> Also, let us know all the results of your tests of various kernels.

dmidecode says:

Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: Phoenix Technologies LTD
                Version: A12
                Release: 07/04/2000
                BIOS base: 0xEA3D0
                ROM size: 192K
                Capabilities:
                        Flags: 0x0000000000001F90
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: Dell Computer Corporation
                Product: Inspiron 7500
                Version: Revision B0
                Serial Number: 123456789

and from another laptop exhibiting the same problem:

Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: Phoenix Technologies LTD
                Version: A06
                Release: 05/19/2000
                BIOS base: 0xEA380
                ROM size: 192K
                Capabilities:
                        Flags: 0x0000000000001F90
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: Dell Computer Corporation
                Product: Inspiron 5000
                Version: Revision B0
                Serial Number: 123456789

Again: both laptops oops with 2.4.9-ac16 when PnPBIOS is enabled, both 
work fine with 2.4.10-ac4 even with PnPBIOS enabled.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
