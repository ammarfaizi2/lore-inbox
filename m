Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264581AbTDPUuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTDPUuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:50:18 -0400
Received: from mail.hometree.net ([212.34.181.120]:21463 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S264581AbTDPUuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:50:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 21:02:08 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b7kgcg$4ao$2@tangens.hometree.net>
References: <785F348679A4D5119A0C009027DE33C102E0D127@mcoexc04.mlm.maxtor.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1050526928 4440 212.34.181.4 (16 Apr 2003 21:02:08 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Apr 2003 21:02:08 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mudama, Eric" <eric_mudama@maxtor.com> writes:

>So the quantum bigfoot doesn't support setting the multiple block size?

>Hrm, how old is that disk?  SET MULTIPLE MODE has been an ATA standard
>command since rev 3 of the spec, circa 1997...

>I guess that is what Alan meant when he said people throw everything at
>linux hardware wise...

What makes you think that?

% hdparm -I /dev/hda
non-removable ATA device, with non-removable media
        Model Number:           QUANTUM BIGFOOT_CY6480A
        Serial Number:          166702123281        
        Firmware Revision:      A03.0500
[...]
        r/w multiple sector transfer: Max = 32  Current = 32
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=333ns  IORDY flow control=120ns

To me it seems to do multi sector transfers just fine. It does it even
better than the 60 GB IBM drive in this box which is much newer but
can do only 16 sectors.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
