Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281501AbRKHKwl>; Thu, 8 Nov 2001 05:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281509AbRKHKwb>; Thu, 8 Nov 2001 05:52:31 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:31759 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281501AbRKHKwP>;
	Thu, 8 Nov 2001 05:52:15 -0500
Message-ID: <3BEA63DD.4080200@epfl.ch>
Date: Thu, 08 Nov 2001 11:52:13 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Robert Love <rml@tech9.net>
Subject: [PATCH][CFT] AGPGART fixes for several Intel chipsets
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

The patch that provides agp support for Intel 820 chipsets is available 
for kernel 2.4.14(final). Please test and report/comment.
I also provide a bigger patch that also fixes the erroneous 16 bits 
writes/reads to the APSIZE register, which is 8 bits for 820, 840, 845, 
850 and 860 chipsets. Please test, and send me your comments/suggestions 
to improve this. It is working for me (Intel 820), but I need feedback 
from people having othjer chipsets.

You can find all the patches at http://ltswww.epfl.ch/~aspert/patches/

Nicolas.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

