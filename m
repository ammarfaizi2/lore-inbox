Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRDPBP1>; Sun, 15 Apr 2001 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132823AbRDPBPS>; Sun, 15 Apr 2001 21:15:18 -0400
Received: from quechua.inka.de ([212.227.14.2]:25370 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132822AbRDPBO7>;
	Sun, 15 Apr 2001 21:14:59 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
In-Reply-To: <20010415195903.1D0F7683B@mail.clouddancer.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14oxbX-0000oM-00@sites.inka.de>
Date: Mon, 16 Apr 2001 03:14:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010415195903.1D0F7683B@mail.clouddancer.com> you wrote:
>>(There is no config file to disable/alter this .. no work-around that I
>>know of ..)

> You can't be serious.  Go sit down and think about what's going on.

Well, there are two potential solutions:

a) stop rebuild until fsck is fixed
b) wait with fsck until rebuild is fixed

Both of them are valid. The first one is valid in a scenario where you want to
decrease downtimes in favor of insecure operation/or multiple redundancy

The second one is good if you prefer data consitency over small down times. It
might actually speed up the bootup process, one has to measure this.

Greetings
Bernd
