Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271938AbRH2JSe>; Wed, 29 Aug 2001 05:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRH2JSY>; Wed, 29 Aug 2001 05:18:24 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:28431 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S271938AbRH2JSS>;
	Wed, 29 Aug 2001 05:18:18 -0400
Date: Wed, 29 Aug 2001 11:18:33 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: linux-2.4.9 , "illegal" MIN and MAX macros spotted
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B8CB369.1BFCE73E@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux 2.4.9

in drivers/media/video/saa5249.c, line 125 :

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
