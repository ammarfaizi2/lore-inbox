Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317807AbSGPI53>; Tue, 16 Jul 2002 04:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSGPI52>; Tue, 16 Jul 2002 04:57:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19706 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317807AbSGPI52>; Tue, 16 Jul 2002 04:57:28 -0400
Subject: Re: Linux 2.4.19-rc1-ac5 -- Build error in mpparse.c (possible fix)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: linux-kernel@vger.kernel.org, miles@megapathdsl.net, lostlogic@gentoo.org
In-Reply-To: <20020716075437.GA9226@lnuxlab.ath.cx>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
	<1026792066.1417.19.camel@localhost.localdomain> 
	<20020716075437.GA9226@lnuxlab.ath.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 11:09:04 +0100
Message-Id: <1026814144.1687.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 08:54, khromy wrote:
> I don't know how correct the following patch might be, but it allows
> mpparse.c to compile.

Its a bit more complex. There are some screwups that break builds where
SMP is N and APIC is Y. I'm just building some test kernels now to see
if I have them resolved

