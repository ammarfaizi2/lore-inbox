Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281776AbRKRXg3>; Sun, 18 Nov 2001 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281822AbRKRXgU>; Sun, 18 Nov 2001 18:36:20 -0500
Received: from quechua.inka.de ([212.227.14.2]:18770 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281776AbRKRXgO>;
	Sun, 18 Nov 2001 18:36:14 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <20011118230540.A2042@werewolf.able.es>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E165bTv-0007EJ-00@calista.inka.de>
Date: Mon, 19 Nov 2001 00:36:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011118230540.A2042@werewolf.able.es> you wrote:
>>Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out 
>>to disk - even without "swap space". Disabling swapspace simply forces the 
>>kernel to swap out more code, since it cannot swap out any data.
>>

> Sure ??? Where ?? What disk space uses it to swap pages to ?

It does not swap code pages out. It simply forgets them and reloads ("page
them in") them when needed.

Greeetings
Bernd
