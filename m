Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUGFTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUGFTJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGFTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:09:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264299AbUGFTJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:09:36 -0400
Date: Tue, 6 Jul 2004 21:09:35 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0-rc1 available at http://people.redhat.com:~heinzm/sw/dmraid
Message-ID: <20040706190935.GA26264@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0-rc1 ***

dmraid 1.0.0-rc1 available at http://people.redhat.com:/~heinzm/sw/dmraid/
in source and i386 rpm.

dmraid (Device-Mapper Raid tool) discovers, [de]activates and displays
properties of software RAID sets (ie. ATARAID) and contained MSDOS
partitions using the device-mapper runtime of the 2.6 kernel.

The following ATARAID types are supported on Linux 2.6:

Highpoint HPT37X
Highpoint HPT45X
Promise FastTrack
Silicon Image Medley

These ATARAID types can be discovered only in this version:
Intel Software RAID
LSI Logic MegaRAID

Please provide insight to support those metadata formats completely.

Thanks.

See file README, which comes with the source tarball for prerequisites
to run this software and further instructions on installing and using dmraid!


Call for testers:
-----------------

I need testers with the above ATARAID types, to check that the mapping
created by this tool is correct (see options "-t -ay") and access to the ATARAID
data is proper.

You can activate your ATARAID sets without danger of overwriting
your metadata, because dmraid accesses it read-only unless you use
option -E with -r in order to erase ATARAID metadata (see 'man dmraid')!

This is a release candidate version so you want to have backups of your valuable
data *and* you want to test accessing your data read-only first in order to
make sure that the mapping is correct before you go for read-write access.


The author is reachable at <Mauelshagen@RedHat.com>.

For test results, mapping information, discussions, questions, patches,
enhancement requests, free beer offers and the like, please subscribe and
mail to <ataraid@redhat.com>.

--

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
