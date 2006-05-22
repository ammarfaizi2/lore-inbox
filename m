Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWEVDXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWEVDXA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWEVDXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:23:00 -0400
Received: from msr22.hinet.net ([168.95.4.122]:26798 "EHLO msr22.hinet.net")
	by vger.kernel.org with ESMTP id S965003AbWEVDW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:22:59 -0400
Message-ID: <004c01c67d4e$e6989c00$4964a8c0@icplus.com.tw>
From: =?utf-8?B?amVzc2VcKOW7uuiIiFwp?= <jesse@icplus.com.tw>
To: "Francois Romieu" <romieu@fr.zoreil.com>,
       "David Vrabel" <dvrabel@cantab.net>
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>, <david@pleyades.net>
References: <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI> <20060502214520.GC26357@electric-eye.fr.zoreil.com> <20060502215559.GA1119@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI> <20060503233558.GA27232@electric-eye.fr.zoreil.com> <1146750276.11422.0.camel@localhost> <20060504235549.GA9128@electric-eye.fr.zoreil.com> <446F840E.3020808@cantab.net> <20060521101620.GA28210@electric-eye.fr.zoreil.com>
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Date: Mon, 22 May 2006 11:22:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois:

Thanks for your help.
I will try this patch and test it.
http://www.fr.zoreil.com/people/francois/misc/20060521-2.6.17-rc4-git-ip1000-test.patch

Jesse

----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "David Vrabel" <dvrabel@cantab.net>
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>; <linux-kernel@vger.kernel.org>;
<netdev@vger.kernel.org>; <david@pleyades.net>; <jesse@icplus.com.tw>
Sent: Sunday, May 21, 2006 6:16 PM
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h


David Vrabel <dvrabel@cantab.net> :
[...]
> 0007-ipg-plug-leaks-in-the-error-path-of-ipg_nic_open.txt broke receive
> since it was skipping the initialization of the Rx buffers.  Patch
attached.

Oops. Applied to branch netdev-ipg of
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git

(please include the '-p' option in future invocation of diff)

I have put an updated patch against 2.6.17-rc4 for the whole driver at
http://www.fr.zoreil.com/people/francois/misc/20060521-2.6.17-rc4-git-ip1000-test.patch

-- 
Ueimor

