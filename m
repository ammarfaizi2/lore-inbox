Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSLCA4e>; Mon, 2 Dec 2002 19:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLCA4e>; Mon, 2 Dec 2002 19:56:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41677 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265815AbSLCA4d>;
	Mon, 2 Dec 2002 19:56:33 -0500
Subject: [PATCHSET] linux-2.4.20_summit_A0 (0/4)
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038877250.6884.21.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:00:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 
	Here is the Summit patch set again. This code is necessary in order to
boot w/ more then 4 physical cpus on a multi-CEC x440 system. All of
these patches were originally from James Cleverdon's Summit patch, which
I have broken up into smaller hopefully more digestable pieces. Thus all
credit is James' and all the blame is mine. 

The set is as follows:

1/4: Clustered apic tweaks
2/4: Logical/Physical apicid additions
3/4: CLUSTERED_APIC_XAPIC switches
4/4: CONFIG_X86_SUMMIT, autodetection, cleanup


Please consider for inclusion. 

thanks
-john

