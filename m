Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTIDNOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTIDNOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:14:09 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:11793 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264979AbTIDNOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:14:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss update for 2.4.23-pre2
Date: Thu, 4 Sep 2003 08:14:04 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052B74@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss update for 2.4.23-pre2
Thread-Index: AcNytX+fGvvlIahCTQWfIL9if2eMCAAMIcog
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <arjanv@redhat.com>
Cc: <axboe@suse.de>, <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2003 13:14:04.0804 (UTC) FILETIME=[6A4DE440:01C372E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We didn't want to permanently allocate more majors than we already have.

mikem

-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com]
Sent: Thursday, September 04, 2003 2:23 AM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; marcelo@conectiva.com.br;
linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.4.23-pre2


On Thu, 2003-09-04 at 00:43, mike.miller@hp.com wrote:
> This patch was built & tested using 2.4.22 with the 2.4.23-pre2 prepatch applied. It is intended for inclusion in the 2.4.23 kernel.
> This patch adds support for more than 8 controllers. It does this by passing 0 as a major number and allows the OS to assign a dynamically allocated major number when there are more than 8 cciss controllers in a system.
> It's primary purpose is to help support the SA6400 and SA6400 EM. When these 2 cards are used they are 2 separate controllers in a single PCI/PCI-X slot.

how about just getting more official majors instead ?
