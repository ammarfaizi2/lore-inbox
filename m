Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbSIXVFT>; Tue, 24 Sep 2002 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSIXVFS>; Tue, 24 Sep 2002 17:05:18 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:46045 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S261814AbSIXVFP>; Tue, 24 Sep 2002 17:05:15 -0400
Message-ID: <3D90D4B9.9080802@nortelnetworks.com>
Date: Tue, 24 Sep 2002 17:10:17 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
Cc: pwaechtler@mac.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <20020924201908.AAA16336@shell.webmaster.com@whenever>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	The main reason I write multithreaded apps for single CPU systems is to 
> protect against ambush. Consider, for example, a web server. Someone sends it 
> an obscure request that triggers some code that's never run before and has to 
> fault in. If my application were single-threaded, no work could be done until 
> that page faulted in from disk.

This is interesting--I hadn't considered this as most of my work for the 
past while has been on embedded systems with everything pinned in ram.

Have you benchmarked this?  I was under the impression that the very 
fastest webservers were still single-threaded using non-blocking io.

Chris

