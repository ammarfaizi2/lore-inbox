Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945945AbWJ0Fhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbWJ0Fhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWJ0Fhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:37:35 -0400
Received: from web54511.mail.yahoo.com ([206.190.49.161]:18026 "HELO
	web54511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1945945AbWJ0Fhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:37:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=beOd/tIjwscBizDXmShBoa2VMOddJLUkvLZBhNuEqI5Syt3epBz09FdM6IRxMkKrViXUzcPi1/rf6QdLBFWO6T/6C+8/+w/bhzDuwqmPjgZ+iNE3XhKJAb4CqV1m2R3A3S59izvT37x0TH3yf6HC1PyGdQgwXsKku0V8REmZ4jg=  ;
Message-ID: <20061027053731.57351.qmail@web54511.mail.yahoo.com>
Date: Thu, 26 Oct 2006 22:37:31 -0700 (PDT)
From: Indian Mogul <indian_mogul@yahoo.com>
Subject: CPU Loading
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

****Apologies if I have posted at the wrong mailing
list ***** 

Hi,

I need some help in understanding the impact of cpu
loading and 
multimedia characteristics. My current system is
Pentium4, HT, 1GB Ram; i am also using LInux 2.6.18.1
kernel (vanilla). For stressing the cpu, I am 
using interbench which run a loop using asm volatile
identifier and the multimedia player I am using is
mplayer.

Here are my steps:
1. Fire Interbench in the background. Using top I see
that the CPU 
utlization is 99.1%.
2. Fire mplayer with Interbench running.

Both of them have equal priority.

However, I am NOT seeing any impact of loading the cpu
on the performance of mplyaer (i.e no dropped frames,
lack of synchronization,...). 

How can I load the CPU such that the scheduling time
slice is insuffucent for mplayer to playout the video?
To the mplayer the system thus appears "slow" ?

Thanks,
IM



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
