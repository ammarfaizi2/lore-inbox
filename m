Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbTIWTS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIWTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:18:23 -0400
Received: from palrel13.hp.com ([156.153.255.238]:37863 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263463AbTIWTR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:17:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.40001.632466.644215@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 12:17:21 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030923114744.137d5dac.davem@redhat.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
	<16240.36993.148535.613568@napali.hpl.hp.com>
	<20030923114744.137d5dac.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 11:47:44 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> No other port is so obstinate about printing out unaligned
  DaveM> kernel access messages, why does ia64 have to be so
  DaveM> different?

Look, this may be difficult for you to understand, but different
people find different policies useful.  I absolutely want to see when
unaligned accesses happen, because it's almost always a performance
issue, if not an outright bug.  If you don't like the current
mechanisms to control the policy for handling unaligned accesses, make
them better.  Don't try to tell me that the policy I want is
"wrong"---that will get you nowhere.

	--david
