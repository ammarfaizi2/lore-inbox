Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHaUfn>; Fri, 31 Aug 2001 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbRHaUfe>; Fri, 31 Aug 2001 16:35:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60548 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269186AbRHaUfW>;
	Fri, 31 Aug 2001 16:35:22 -0400
Message-ID: <3B8FF4D4.BC5FA378@rchland.vnet.ibm.com>
Date: Fri, 31 Aug 2001 15:34:28 -0500
From: David Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; AIX 4.3)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        linuxppc64-dev@lists.linuxppc.org
CC: tom_gall@vnet.ibm.com
Subject: [PATCH] ppc64 update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

The patch referenced here provides updates for ppc64. The changes
include
bug fixes, performance fixes, feature enhancements, and general cleanup.

This patch applies against 2.4.9-ac3 and can be found at:

ftp.kernel.org:/pub/linux/kernel/people/tgall/linuxppc64-2.4.9-ac3-ibm-2.patch.gz

ppc64 users should be cautioned as this is not a complete patch.
Additional
patches can be found on linuxppc64.org.

Highlights of this patch (in no particular order):

- cleanup and removal of work arounds for gcc 2.95.3, gcc 3.0.1 now
required
- documentation of new configuration options
- cleanup of Config.in (thanks to Andrzej Krzysztofov)
- zImage, SBSS, BSS fixes
- iSeries machines are now supported
- > 3 gig memory support on p640 bug fix
- mschunks for sparce discontiguous memory support
- bolt all real pages in the HPT

Thanks to the members of the ppc64 team who have all contributed to the
code:

Peter Bergner, Anton Blanchard, Mike Corrigan, Dave Engebretsen,
Tom Gall, Todd Inglett, Paul Mackerras, Pat McCarthy, Steve Munroe,
Don Reed, and Al Trautman.

Dave Engebretsen
IBM Corp
PPC64 Development



