Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTB0XW5>; Thu, 27 Feb 2003 18:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTB0XW5>; Thu, 27 Feb 2003 18:22:57 -0500
Received: from daimi.au.dk ([130.225.16.1]:47593 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267329AbTB0XW4>;
	Thu, 27 Feb 2003 18:22:56 -0500
Message-ID: <3E5EA035.C25BF0E5@daimi.au.dk>
Date: Fri, 28 Feb 2003 00:33:09 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
		<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<3E5DB2CA.32539D41@daimi.au.dk>
		<buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<3E5DCB89.9086582F@daimi.au.dk>
		<buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<20030227092121.GG15254@pegasys.ws> <buovfz6qcir.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> 
> I think making /proc/{mount,mtab,...,whatever} work correctly is
> certainly the best thing to do.

I think we all agree on that. But then what is the correct way for
that to work? And is that possible? Should any of the fields be
written by userspace utilities, or is the kernel supposed to know
the right value for every field? What should be in the device
field in case of loopback and bind mounts?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
