Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278447AbRJ3NdS>; Tue, 30 Oct 2001 08:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279794AbRJ3NdJ>; Tue, 30 Oct 2001 08:33:09 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:43181 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S278447AbRJ3Ncz>; Tue, 30 Oct 2001 08:32:55 -0500
Date: Tue, 30 Oct 2001 14:29:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Green <greeen@iii.org.tw>
cc: LinuxEmbeddedMailList <linux-embedded@waste.org>,
        LinuxKernelMailList <linux-kernel@vger.kernel.org>,
        MipsMailList <linux-mips@fnet.fr>
Subject: Re: Discontinuous memory!!
In-Reply-To: <00c701c1612b$4c133620$4c0c5c8c@trd.iii.org.tw>
Message-ID: <Pine.GSO.3.96.1011030142241.6694F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Green wrote:

> How could I modify the kernel to support 32MB discontinuous memory?

 You need to call add_memory_region() for each continuous physical memory
area.  See how it's done for other platforms.

 Note that <linux-mips@oss.sgi.com> is probably the best place to discuss
MIPS/Linux issues.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

