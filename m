Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbXAQQny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAQQny (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbXAQQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:43:54 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:45333 "EHLO
	ccerelbas01.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXAQQnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:43:53 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PME_Turn_Off in Linux
Date: Wed, 17 Jan 2007 10:43:14 -0600
Message-ID: <E717642AF17E744CA95C070CA815AE550116B7C8@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PME_Turn_Off in Linux
Thread-Index: Acc6VpTzvcmrLSBzTris5wTB9VXnag==
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "LKML" <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Brainard, Jim" <jim.brainard@hp.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
X-OriginalArrivalTime: 17 Jan 2007 16:43:15.0403 (UTC) FILETIME=[958D91B0:01C73A56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We've been seeing some nasty data corruption issues on some platforms.
We've been capturing PCI-E traces looking for something nasty but we
haven't found anything yet. One of the hardware guys if asking if there
is a call in Linux to issue a PME_Turn_Off broadcast message.
 
PME_Turn_Off Broadcast Message
Before main component power and reference clocks are turned off, the
Root Complex or Switch Downstream Port must issue a broadcast Message
that instructs all agents downstream of that point within the hierarchy
to cease initiation of any subsequent PM_PME Messages, effective
immediately upon receipt of the PME_Turn_Off Message.

This must be initiated from the root complex. Is there such a call in
linux?

Thanks,
mikem

