Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbTAaJiA>; Fri, 31 Jan 2003 04:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267741AbTAaJiA>; Fri, 31 Jan 2003 04:38:00 -0500
Received: from daimi.au.dk ([130.225.16.1]:59521 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267740AbTAaJh7>;
	Fri, 31 Jan 2003 04:37:59 -0500
Message-ID: <3E3A4627.993A4B59@daimi.au.dk>
Date: Fri, 31 Jan 2003 10:47:19 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: doubts in INIT - while system booting up
References: <200301310921.h0V9LJxZ002780@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> > > >        INIT: Id "x" respawing too fast: disabled for 5
> 
> I've seen such problems too, caused by full /tmp

Yes IIRC in that case xfs will fail to create /tmp/.font-unix
and the socket /tmp/.font-unix/fs7100 and X will fail because
of the missing font server.

Anyway, I was just stating that it could be caused by a
misconfigured kernel.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
