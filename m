Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVIWHto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVIWHto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVIWHto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:49:44 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:54277 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbVIWHto convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:49:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BJVnA6XN1VGdDKTysR0qCC5MrCE3T1i873FbA72/44pV4mgPV+xs/RxLh3Clp3ZTHjmHM/gfGEOLtWTDV3VbrYHDDaPYLUaHLtm8nPNq0KbnJL/vB+br+M3ZmEwos3plKACe8X0ZsMFsowb1y/FMas/l1HWoaMVsO37FuKG6O98=
Message-ID: <cda58cb805092300496abc8350@mail.gmail.com>
Date: Fri, 23 Sep 2005 09:49:43 +0200
From: Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: How to add a new ram region ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on port of linux 2.6.13. The target is a custom board
based on a MIPS cpu. There are several RAMs on this board whose
address are not contiguous and don't start to 0 . I currently succeed
to make linux detect one of these RAM (the biggest one) but I'd like
to make linux able to use the others...I'd like to use the other in a
particular way: I would like to be able to allocate memory only on a
single RAM when needed in kernel space, and in userspace I would be
able to export a RAM disk that uses memory on a single RAM.

Could someone tell me how to do that or give me some pointers  ?

Thanks
--
               Franck
