Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTH1NkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTH1NkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:40:14 -0400
Received: from nice-1-a7-62-147-77-76.dial.proxad.net ([62.147.77.76]:56326
	"EHLO monpc") by vger.kernel.org with ESMTP id S263989AbTH1NkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:40:11 -0400
From: Guillaume Chazarain <guichaz@yahoo.fr>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2003 15:43:56 +0200
X-Priority: 3 (Normal)
Message-Id: <A00409NJIDDBTRJI86KG96C8BZX3VHF.3f4e071c@monpc>
Subject: Re: [PATCH]O18.1int
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

28/08/03 14:34:15, Nick Piggin <piggin@cyberone.com.au> wrote:
>Guillaume Chazarain wrote:
>
>>Hi Con (and linux-kernel),
>>
>>I noticed a regression wrt 2.6.0-test4 and 2.4.22 with this
>>big context-switcher:
>>
>
>Hi Guillaume,
>If you get the time, would you be able to try my patch? Thanks.

Here are the results for Nick's v8:

top(1):

  639 g         30   0  1336  260 1308 R 51.2  0.1   0:03.80 a.out
  638 g         22   0  1336  260 1308 S 47.3  0.1   0:03.39 a.out

User time (seconds): 0.57
System time (seconds): 2.72
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:06.85
Minor (reclaiming a frame) page faults: 17


Guillaume.




