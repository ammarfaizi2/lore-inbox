Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbRARVae>; Thu, 18 Jan 2001 16:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRARVaY>; Thu, 18 Jan 2001 16:30:24 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:33004 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S130159AbRARVaO>; Thu, 18 Jan 2001 16:30:14 -0500
Message-ID: <3A6760E8.C7023346@netcomuk.co.uk>
Date: Thu, 18 Jan 2001 21:32:24 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with networking in 2.4.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 In connection with connection failures using recent kernels, it often
seems to be related to ECN being enabled.

 PIX firewalls seem to interpret the ECN option header as a source
route header (that's what it's logged as).

 I got bitten by this at work ;·(

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
