Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLJRJ5>; Tue, 10 Dec 2002 12:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSLJRJ5>; Tue, 10 Dec 2002 12:09:57 -0500
Received: from ext-nj2gw-3.online-age.net ([216.35.73.165]:53747 "EHLO
	ext-nj2gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S262646AbSLJRJz>; Tue, 10 Dec 2002 12:09:55 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA68048955F9@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Dan Kegel'" <dkegel@ixiacom.com>, linux-kernel@vger.kernel.org
Subject: RE: [RFC] countdown timer driver
Date: Tue, 10 Dec 2002 12:17:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Questions:
> > 1. Is there already a standard kernel interface to this 
> type of timer?
> 
> The Posix high-res timer stuff, I think.  Have you tried expressing
> what you want user programs to do in terms of Posix high-res 
> timers yet?
> 
> > 2. Is there any reason to interface/integrate this type of 
> device with the
> >    high-res timer stuff currently under development for the 
> 2.5 kernel?
> 
> Yes; perhaps you could create a service provider interface
> for the posix high-res timer stuff, then use that SPI
> to plug your hardware in?
> 
> I may be way off base here, but it does seem like it's due dilligence
> to verify that you're not reinventing an interface here.

Yes, the first intent of this request is to see if there is a suitable
interface already available.

I will follow up about the service provider interface on the high-res timer
list.

Thanks.
