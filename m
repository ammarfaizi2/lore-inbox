Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTI0SMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTI0SMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:12:25 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.102]:53232 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262126AbTI0SMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:12:23 -0400
Message-ID: <3F75D35C.9040609@softhome.net>
Date: Sat, 27 Sep 2003 20:13:48 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb
 ram under moderate load
References: <Apl1.4ur.9@gated-at.bofh.it> <Ar3B.6UW.21@gated-at.bofh.it>
In-Reply-To: <Ar3B.6UW.21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Sun, 28 Sep 2003 01:26:34 +1000, Jason Lewis wrote:
>> 0 12      0   3424    816   6008    0    0 19712     0 5519  3184  0 12  0 87
> 
>           ^^^^
> Looks like you don't have swap enabled. Are successful 2.4 runs with or
> without swap?
> 

    I'm running RH stock 2.4.20-20.9 without swap for around month.
    OOo, Mozilla, eDonkey & heaps of xterms. Even evaluation of VMware 
with Win2K inside was Ok.
    On average: much better experience.

$ free
              total       used       free     shared    buffers     cached
Mem:        513872     507128       6744          0      32784     341404
-/+ buffers/cache:     132940     380932
Swap:            0          0          0

$ vmstat
    procs                      memory      swap          io     system 
     cpu
  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs 
us sy id
  0  0  0      0   6744  32708 341292    0    2     6    24   17    39 
3  1 16


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

