Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTEVT1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTEVT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:27:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64987 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263176AbTEVT1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:27:07 -0400
Date: Thu, 22 May 2003 12:39:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Larson <plars@linuxtestproject.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: 2.5.69-mm8
Message-ID: <9790000.1053632393@[10.10.2.4]>
In-Reply-To: <1053631843.2648.3248.camel@plars>
References: <20030522021652.6601ed2b.akpm@digeo.com> <1053629620.596.1.camel@teapot.felipe-alfaro.com> <1053631843.2648.3248.camel@plars>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
>> > 
>> > . One anticipatory scheduler patch, but it's a big one.  I have not stress
>> >   tested it a lot.  If it explodes please report it and then boot with
>> >   elevator=deadline.
>> > 
>> > . The slab magazine layer code is in its hopefully-final state.
>> > 
>> > . Some VFS locking scalability work - stress testing of this would be
>> >   useful.
>> 
>> Running on it right now... Compiles and boots. I'm sure it won't explode
>> on my face :-)
> 2.5.69-mm8 is bleeding for me. :)  See bugs #738 and #739.  I don't
> *think* they are the same but apologies in advance if they are.  #738
> appears to have been produced mostly by running LTP and #739 I got with
> a combination of ftest07 and aio01 from LTP and previously just by
> compiling LTP.

Also seems to hang rather easily. When it gets into that state, it's difficult
to tell what works and what doesn't ... I can login over serial, but not 
start new ssh's and "ps -ef" hangs for ever. I'll try to get some more
information, and assemble a less-totally-crap bug report.

M.
