Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVF3TM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVF3TM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVF3TM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:12:59 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:3193 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262964AbVF3TM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:12:57 -0400
X-IronPort-AV: i="3.94,155,1118034000"; 
   d="scan'208"; a="260760735:sNHT26414772"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Thu, 30 Jun 2005 14:11:10 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B407434D@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV9mgpSa+MuTDTrQMaLclcywN+W7QADQn8w
From: <Stuart_Hayes@Dell.com>
To: <arjan@infradead.org>
Cc: <ak@suse.de>, <riel@redhat.com>, <andrea@suse.dk>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jun 2005 19:11:10.0909 (UTC) FILETIME=[79F5CED0:01C57DA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2005-06-30 at 11:56 -0500, Stuart_Hayes@Dell.com wrote:
>> Andi Kleen wrote:
>>> 
>>> I only fixed it for x86-64 correct. Does it work for you on x86-64?
>>> 
>>> If yes then the changes could be brought over.
>>> 
>>> What do you all need is for anyways?
>>> 
>>> -Andi
>> 
>> We need this because the NVidia driver uses change_page_attr() to
>> make pages non-cachable, which is causing systems to spontaneously
>> reboot when it gets a page that's in the first 8MB of memory.
>> 
> 
> that's not a linux problem since there isn't really a linux driver
> that does this ;) 

That's why I didn't mention what failed in the first place!  :P
