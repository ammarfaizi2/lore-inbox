Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290083AbSAQRTG>; Thu, 17 Jan 2002 12:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290079AbSAQRSz>; Thu, 17 Jan 2002 12:18:55 -0500
Received: from f198.law15.hotmail.com ([64.4.23.198]:49158 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290078AbSAQRSv>;
	Thu, 17 Jan 2002 12:18:51 -0500
X-Originating-IP: [128.112.49.17]
From: "Yinlei Yu" <yinlei_yu@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is there anyway to use 4M pages on x86 linux in user level?
Date: Thu, 17 Jan 2002 12:18:45 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F198nwpGR881Np7vXee0002516d@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2002 17:18:45.0692 (UTC) FILETIME=[05025FC0:01C19F7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a project that keep accessing lots of memory randomly(say 
500MB-1.5GB) and we do have such amount of memory installed so there's 
almost no page faults while running the entire program. Since x86 
architecutre has a 4M page feature, is it possible to make use of these big 
pages instead of 4K pages in my program (a user-level application) so I can 
expect much fewer TLB misses due to the reduced number of TLB entries? 
Thanks very much!






_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

