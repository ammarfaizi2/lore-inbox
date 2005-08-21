Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVHUBru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVHUBru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVHUBru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:47:50 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:32138 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750756AbVHUBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:47:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Sun, 21 Aug 2005 11:47:39 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e05081614498879a72@mail.gmail.com> <6bffcb0e05082018346f073ca4@mail.gmail.com>
In-Reply-To: <6bffcb0e05082018346f073ca4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508211147.39503.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005 11:34, Michal Piotrowski wrote:
> Hi,

Hi

> here are kernbench results:

Nice to see you using kernbench :)

> ./kernbench -M -o 128
> [..]
> Average Optimal -j 128 Load Run:

Was there any reason you chose 128? Optimal usually works out automatically 
from kernbench to 4x number_cpus. If I recall correctly you have 4 cpus? Not 
sure what 128 represents. 

Cheers,
Con
