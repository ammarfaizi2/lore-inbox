Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267930AbSISNLq>; Thu, 19 Sep 2002 09:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbSISNLq>; Thu, 19 Sep 2002 09:11:46 -0400
Received: from math.ut.ee ([193.40.5.125]:14727 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267930AbSISNLp>;
	Thu, 19 Sep 2002 09:11:45 -0400
Date: Thu, 19 Sep 2002 16:15:52 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: Roger Gammans <roger@computer-surgery.co.uk>
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       Clint Byrum <cbyrum@spamaps.org>
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
In-Reply-To: <20020813133159.A21210@computer-surgery.co.uk>
Message-ID: <Pine.GSO.4.44.0209191614360.24450-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen these sort of symptoms before and it turned out
> to be faulty memory.

The mystery has been solved - after the symptoms appeared again (this
time certain outgoing packets didn't get through), I ran memtest86 for
night and it showed bad memory.

-- 
Meelis Roos             e-mail: mroos@ut.ee
                        www:    http://www.cs.ut.ee/~mroos/

