Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbREUVtB>; Mon, 21 May 2001 17:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbREUVsv>; Mon, 21 May 2001 17:48:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32251 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262500AbREUVsi>; Mon, 21 May 2001 17:48:38 -0400
Message-ID: <3B098CF6.722B2B9D@vnet.ibm.com>
Date: Mon, 21 May 2001 21:47:34 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: PATCH: New iSeries Device Drivers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed you will find for your consideration a set of new device drivers for
iSeries boxes. This submission is against 2.4.4. 

Additionally in the background there is also a submission which has been made to
the ppc maintainers for the set of changes to arch/ppc and include/asm-ppc to
enable iSeries boxes to run Linux. Those should bubble up soon.

The new device drivers are for:

virtual console
virtual harddrive
virtual ethernet
virtual tape
virtual cd

These device drivers will also be used in the up coming ppc64 architecture.

Rather than spamming the list with ~6800 lines of driver code, you can obtain it
via 
http://www.ibm.com/linux/ltc/projects/ppc/patches/patch-lpar-dev.gz or via
ftp.kernel.org/pub/linux/kernel/people/tgall/patch-lpar-dev.gz

Background:

iSeries boxes are otherwise known as IBM's AS/400, a midrange business computer.
Linux runs on these machines in a logical partition, so akin to how the S390
runs Linux, iSeries allows you to have multiple Linux boxes running side by side
on the same machine. Since multiple linux boxes must share physical resources,
these virtual drivers were developed. The virtual ethernet goes a step beyond
and allows you to setup your own high speed lan "inside" of the box without
consuming physical resources.

Also see http://www.ibm.com/linux/ltc/projects/ppc/iSeries_notes.php or
http://www.ibm.com/servers/eserver/iseries/linux/ for more information.

Regards,

Tom
-- 
Tom Gall - PPC64                 "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
