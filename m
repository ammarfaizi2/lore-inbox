Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319476AbSH3Htt>; Fri, 30 Aug 2002 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319478AbSH3Htt>; Fri, 30 Aug 2002 03:49:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:11277 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319476AbSH3Hts>; Fri, 30 Aug 2002 03:49:48 -0400
Message-ID: <3D6F24B3.858E59D8@aitel.hist.no>
Date: Fri, 30 Aug 2002 09:54:27 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com> <1030618420.7290.112.camel@irongate.swansea.linux.org.uk> <aklq8b$220$1@penguin.transmeta.com> <3D6E90AB.FBA3BDE6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> How about { 50, 50, "power-save" }  where the number refers
> to percent of full?
> I.e. same meaning IFF full is 600, but suppose it is 800.

Percentages don't buy you anything.  Sure, a new cpu has a
different max setting, but you may get the same problem with your
percentages:

The "old" cpu ran well with 50% for power saving and 100% for
performance.  The "new" might want 30% for power to work
well.  So, the numbers change anyway.

Helge Hafting
