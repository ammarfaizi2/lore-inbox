Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSFRMAD>; Tue, 18 Jun 2002 08:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSFRMAC>; Tue, 18 Jun 2002 08:00:02 -0400
Received: from kim.it.uu.se ([130.238.12.178]:19343 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317388AbSFRMAC>;
	Tue, 18 Jun 2002 08:00:02 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15631.8381.516022.263531@kim.it.uu.se>
Date: Tue, 18 Jun 2002 13:59:57 +0200
To: Seth Goldberg <Seth.Goldberg@Sun.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: genksyms not doing its job?
In-Reply-To: <Pine.GSO.4.44.0206171700170.197503-100000@limud.sfbay.sun.com>
References: <Pine.GSO.4.44.0206171700170.197503-100000@limud.sfbay.sun.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg writes:
 >   I was wondering if anyone was also experiencing a problem in generating
 > kernel symbols for the 2.5.22 kernel.  I am notificing quite a few ksyms
 > that have not been properly generated (e.g. "sprintf_R__ver_sprintf"
 > instead of "sprintf_Rsmp_xxxxxxxx").  Please pardon me if this is a FAQ,
 > but I have installed the lated modutils and am still experiencing this
 > problem.

Known problem. See yesterday's "2.5.22 broke modversions" thread,
or get the fix from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102432431618537&w=2

/Mikael
