Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272783AbRIMFCN>; Thu, 13 Sep 2001 01:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272794AbRIMFCD>; Thu, 13 Sep 2001 01:02:03 -0400
Received: from anstogw.gw.ansto.gov.au ([137.157.8.253]:17161 "EHLO
	tachyon.gw.ansto.gov.au") by vger.kernel.org with ESMTP
	id <S272783AbRIMFBv>; Thu, 13 Sep 2001 01:01:51 -0400
Date: Thu, 13 Sep 2001 15:01:25 +1000 (EST)
From: Ian Crakanthorp <ian@ansto.gov.au>
Message-Id: <200109130501.PAA08913@hadron.ansto.gov.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac10 st driver (DLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to read from a DLT4000 tape.  The device is found and mt can
talk to it.  But if I try a dd I get:

dd if=/dev/st0 of=/tmp/tape.out bs=16k
dd: reading `/dev/st0': Cannot allocate memory
0+0 records in
0+0 records out

If I try to cat the device, still get the "Cannot allocate memory"

cat /dev/st0 > /tmp/tt
cat: /dev/st0: Cannot allocate memory


Tried the same on an older kernel (2.4.8-ac7) and it worked.  Also the
latest Redhat one works (2.4.3).

Is this a known problem? Or can I give someone more diagnostic information?

Thanks,
Ian...

Ian Crakanthorp				e-mail: Ian.Crakanthorp@ansto.gov.au
Systems Support Manager/Operations Manager
ANSTO
Australian Nuclear Science		phone : +61 2 9717 3365
& Technology Organisation		Fax   : +61 2 9717 9273
