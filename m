Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbRAIXk6>; Tue, 9 Jan 2001 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRAIXks>; Tue, 9 Jan 2001 18:40:48 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:42511 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131095AbRAIXkb>; Tue, 9 Jan 2001 18:40:31 -0500
Message-Id: <200101092340.f09NeTs99249@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
Subject: Adaptec AIC7XXX version 6.08BETA released
Date: Tue, 09 Jan 2001 16:40:29 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6.08BETA of the Adaptec sponsored and supported AIC7XXX
dirver is now available.  Patches against 2.4.0 and 2.2.18 are
provided here:

http://people.FreeBSD.org/~gibbs/linux/

If you are using hardware supported by the aic7xxx driver,
I would appreciate feedback on the new driver.

Changelog:

	o Honor selection timeout settings set by the user.

	o Correct a bug that could cause us to fail a command
	  that underflowed due to a check condition.  We now
	  return DID_OK in this case with the sense information
	  returned.

	o Added initial /proc support.

	o Generate module in SCSI directory so it can be
	  named just like its predecessor.

	o Complete big endian support (untested).

	o Split out our host template definition so we don't
	  muck up the namespace when our template is included
	  in hosts.c

--
Justin

Justin T. Gibbs
OpenSource Embedding
Adaptec Inc.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
