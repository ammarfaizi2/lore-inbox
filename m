Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUDBJec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUDBJec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:34:32 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:33664 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id S263574AbUDBJea convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:34:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Stack of a thread
Date: Fri, 2 Apr 2004 15:02:45 +0530
Message-ID: <B86B0623D89F034AB9CEE1DE2618BC32A97838@webmail.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stack of a thread
Thread-Index: AcQYlZy6l+mMokOuRW20WmbhytcWVA==
From: <anuya.kulkarni@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Apr 2004 09:33:33.0291 (UTC) FILETIME=[90DE7BB0:01C41895]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a doubt regarding stack of a thread.
I want to know how it is organized ?

Say I have a function with 1 input parameter and 
1 local veriable. If I know the stack base pointer, 
can I predict the location of the input parameter and 
local variable. 

I have a POSIX thread with stack base pointer and size of
stack specified by me. RedHat Linux 7.2 (Kernel 2.4.7-10)

Also, if I want to copy the snapshot of stack of this thread and 
map to some memory region on another machine and give this address 
of this region as stack base for the same thread function to run on
other 
machine, will it work as if there is no migration from one machine to 
other ? Here I assume that transfer of stack across machines and
privilages are  
not the issues.

