Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131201AbRCGVQ4>; Wed, 7 Mar 2001 16:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131200AbRCGVQr>; Wed, 7 Mar 2001 16:16:47 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25869
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131194AbRCGVQb>; Wed, 7 Mar 2001 16:16:31 -0500
Date: Wed, 7 Mar 2001 13:15:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Craig Ruff <cruff@ucar.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <20010307135811.A20146@bells.scd.ucar.edu>
Message-ID: <Pine.LNX.4.10.10103071315180.19253-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1019260510-276610108-983999746=:19253"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1019260510-276610108-983999746=:19253
Content-Type: text/plain; charset=us-ascii


Then run this and see if you live.

On Wed, 7 Mar 2001, Craig Ruff wrote:

> On Wed, Mar 07, 2001 at 12:32:08PM -0800, Andre Hedrick wrote:
> > The SCSI low-level format glue performed by the HOST gets destroyed
> > If you write to LBA Zero.
> 
> This is simply not true.  I write to SCSI disk's block 0 all of the time
> and never loose data.  Obviously, you can lose the partition information
> if that is where it is kept.  I've also never had trouble with SCSI
> disks correctly writing multiple sectors starting at block zero.  This
> includes older Quantum drives.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

---1019260510-276610108-983999746=:19253
Content-Type: text/plain; charset=us-ascii; name="scsikiller.c"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10103071315460.19253@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="scsikiller.c"

Lyogc2NzaWtpbGxlci5jICovDQ0KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0N
CiNpbmNsdWRlIDxzeXMvZmNudGwuaD4NDQojaW5jbHVkZSA8c2NzaS9zY3Np
Lmg+DQ0KDQ0Kc3RydWN0IGNkYjZoZHJ7DQ0KCXVuc2lnbmVkIGludCBpbmJ1
ZnNpemU7DQ0KCXVuc2lnbmVkIGludCBvdXRidWZzaXplOw0NCgl1bnNpZ25l
ZCBjaGFyIGNkYiBbNl07DQ0KfSBfX2F0dHJpYnV0ZV9fICgocGFja2VkKSk7
DQ0KDQ0KaW50IG1haW4gKGludCBhcmd2LCBjaGFyICoqYXJnYykNDQp7DQ0K
CWludCBmZDsNDQoJdW5zaWduZWQgY2hhciB0QnVmWzUyNl07DQ0KCXN0cnVj
dCBjZGI2aGRyICppb2N0bGhkcjsNDQoNDQoJaWYgKGFyZ3YgIT0gMikgZXhp
dCgtMSk7DQ0KCQ0NCglmZCA9IG9wZW4gKCooYXJnYysxKSwgT19SRFdSICk7
DQ0KCWlmIChmZCA8IDApIGV4aXQgKC0xKTsNDQoNDQoJbWVtc2V0KCZ0QnVm
LCAwLCA1MjYpOw0NCiAgDQ0KCWlvY3RsaGRyID0gKHN0cnVjdCBjZGI2aGRy
ICopICZ0QnVmOw0NCiAgDQ0KCWlvY3RsaGRyLT5pbmJ1ZnNpemUgPSA1MTI7
DQ0KCWlvY3RsaGRyLT5vdXRidWZzaXplID0gMDsNDQoJaW9jdGxoZHItPmNk
YlswXSA9IFdSSVRFXzY7DQ0KCWlvY3RsaGRyLT5jZGJbNF0gPSAxOw0NCiAg
DQ0KCXJldHVybiBpb2N0bChmZCwgMSwgJnRCdWYpOw0NCn0NDQo=
---1019260510-276610108-983999746=:19253--
