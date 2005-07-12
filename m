Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVGLL7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVGLL7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGLL7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:59:40 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:23012 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261373AbVGLL5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:57:40 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Tue, 12 Jul 2005 04:57:31 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
In-Reply-To: <200507122110.43967.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0507120446450.9200@qynat.qvtvafvgr.pbz>
References: <200507122110.43967.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this looks very interesting, however one thing that looks odd to me in 
this is the thought of comparing the results for significantly different 
hardware.

for some of the loads you really are going to be independant of the speed 
of the hardware (burn, compile, etc will use whatever you have) however 
for others (X, audio, video) saying that they take a specific percentage 
of the cpu doesn't seem right.

if I have a 400MHz cpu each of these will take a much larger percentage of 
the cpu to get the job done then if I have a 4GHz cpu for example.

for audio and video this would seem to be a fairly simple scaleing factor 
(or just doing a fixed amount of work rather then a fixed percentage of 
the CPU worth of work), however for X it is probably much more complicated 
(is the X load really linearly random in how much work it does, or is it 
weighted towards small amounts with occasional large amounts hitting? I 
would guess that at least beyond a certin point the liklyhood of that much 
work being needed would be lower)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
