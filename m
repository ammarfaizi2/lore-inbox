Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275292AbTHSBV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHSBV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:21:28 -0400
Received: from GEWI.kfunigraz.ac.at ([143.50.30.10]:776 "EHLO
	gewi.kfunigraz.ac.at") by vger.kernel.org with ESMTP
	id S275294AbTHSBV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:21:26 -0400
Date: Tue, 19 Aug 2003 03:20:31 +0200 (CEST)
From: Erich Stamberger <eberger@gewi.kfunigraz.ac.at>
To: "Brown, Len" <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: ASUS PR-DLSW: ACPI Bugs
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC6E@hdsmsx402.hd.intel.com>
Message-ID: <Pine.LNX.4.53.0308190256540.31897@gewi.kfunigraz.ac.at>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC6E@hdsmsx402.hd.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

many thanks for your interest.

On Mon, 18 Aug 2003, Brown, Len wrote:

> See that you've got the latest BIOS -- Asus's web page advertises 1008:
> http://www.asus.com/support/download/item.aspx?ModelName=PR-DLSW

That is what I already have (ASUS PR-DLSW ACPI BIOS Revision 1008).

>
> If acpi=off is still required to boot, then file a bug at
> http://bugzilla.kernel.org category=Power Management; Component=ACPI;
> Owner=len.brown@intel.com
>
> Then I'll ask you:
> 1. can you try the latest 2.6 kernel -- it has slightly newer ACPI code.
> 2. can you attach the output of acpidmp:
> http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-200107
> 30.tar.gz
> 3. can you attch the output of dmidecode:
> http://www.nongnu.org/dmidecode/

Tried kernel 2.6.0-test3-bk6. Still needs acpi=ht or acpi=off to boot,
so I filed a bug report and placed all the files you requested on
      http://gewi.kfunigraz.ac.at/~eberger/pr-dlsw/

If you need more info, please let me know.

Best regards
Erich


> > -----Original Message-----
> > From: Erich Stamberger [mailto:eberger@gewi.kfunigraz.ac.at]
> > Sent: Saturday, August 16, 2003 7:57 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: ASUS PR-DLSW: ACPI Bugs
> >
> >
> > Hello,
> >
> > 2.6.0-test3 with ACPI enabled fails to boot on ASUS PR-DLSW: Cannot
> > open root device .. Obviously the SCSI controllers (LSI 1010-66)
> > are not detected (complete dmesg from serial console below).
> >
> > When setting pci=noacpi the machine hangs in an endless loop
> > trying to initialise the SCSI bus.
> >
> > With acpi=off or CONFIG_ACPI_HT_ONLY the machine
> > boots (lspci -vvx below).
> >
> > Any information / pointers will be appreciated.
> >
> > Best regards
> > Erich
