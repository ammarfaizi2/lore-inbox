Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSHSTRZ>; Mon, 19 Aug 2002 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318992AbSHSTRZ>; Mon, 19 Aug 2002 15:17:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6137 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318990AbSHSTRY>; Mon, 19 Aug 2002 15:17:24 -0400
Subject: Re: IDE-flash device and hard disk on same controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Heater, Daniel (IndSys, " "GEFanuc, VMIC)" 
	<Daniel.Heater@gefanuc.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>,
       "Warner, Bill (IndSys, " "GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC1463@vacho6misge.cho.ge.com>
References: <A9713061F01AD411B0F700D0B746CA6802FC1463@vacho6misge.cho.ge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 20:21:00 +0100
Message-Id: <1029784860.19375.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 19:31, Heater, Daniel (IndSys, GEFanuc, VMIC)
wrote:
> One solution may be to remove this test from the IDE subsystem and force
> users with buggy hardware to explicitly  disable probing for a second
> device.  I think the parameters hdx=none or hdx=noprobe should work for
> them.

I'm inclined to agree about this in the absence of very good reasons why
not. The combination is found on several systems nowdays

