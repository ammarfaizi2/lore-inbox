Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbTANDrX>; Mon, 13 Jan 2003 22:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268569AbTANDrX>; Mon, 13 Jan 2003 22:47:23 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:48318 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268567AbTANDrW>; Mon, 13 Jan 2003 22:47:22 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8F1@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 21:55:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We can gather that info at runtime from the processors, when we really need
it. And I don't think we have 
>performance issues this that.

True - it has to be only done once per CPU bring-up.

To investigate all the corners of this issue: is it possible now, tomorrow,
on in the future to mix Intel processors on the same machine? Isn't it
enough really to collect the APIC version of boot CPU and just use it for
the rest? Or do we have to leave the opportunity for such occasion in the
code?


-Natalie
