Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTCEFvo>; Wed, 5 Mar 2003 00:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTCEFvo>; Wed, 5 Mar 2003 00:51:44 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:7362 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262604AbTCEFvn>;
	Wed, 5 Mar 2003 00:51:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
Date: Wed, 5 Mar 2003 17:02:10 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303041354.03428.kernel@kolivas.org> <20030304001032.034f60fa.akpm@digeo.com>
In-Reply-To: <20030304001032.034f60fa.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303051702.10810.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 07:10 pm, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Mem_load result of AS being slower was just plain weird with the result
> > rising from 100 to 150 during testing.
>
> Maybe we should just swap computers or something?
>
> Finished compiling kernel: elapsed: 145 user: 180 system: 18
> Finished mem_load: elapsed: 146 user: 0 system: 2 loads: 5000
> Finished compiling kernel: elapsed: 135 user: 181 system: 17
> Finished mem_load: elapsed: 136 user: 0 system: 2 loads: 4800
> Finished compiling kernel: elapsed: 129 user: 181 system: 17
> Finished mem_load: elapsed: 130 user: 0 system: 2 loads: 4800
>
> 256MB, dual CPU, ext3/IDE.

Tried again - these were done as part of a full contest run, not just mem_load 
by itself, but these were the mem_load results:

98
128
135

then it oopsed (the one I posted earlier) and wasn't really usable after that 
point. Perhaps they're related. The mystery remains. I'll see what happens 
next mm release.

Con


