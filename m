Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264773AbSJaJYU>; Thu, 31 Oct 2002 04:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264781AbSJaJYU>; Thu, 31 Oct 2002 04:24:20 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:64463 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264773AbSJaJYU>; Thu, 31 Oct 2002 04:24:20 -0500
Message-ID: <3DC0F6E1.8060209@drugphish.ch>
Date: Thu, 31 Oct 2002 10:24:49 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] v2.2.22-2-secure // [PATCH | PATCHSET | FULLKERNEL]
References: <200210310057.24743.m.c.p@wolk-project.de> <3DC0DA57.7040900@drugphish.ch> <200210310942.26843.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

> args, you are right. Awfull typo :-( ... What I meant was: 
> http://www.impsec.org/linux/masquerade/ip_masq_vpn.html

So then you would be referring to following patch, right?
http://bmrc.berkeley.edu/people/chaffee/patches/ip_masq_vpn-2.2.10-alpha.patch.gz

After a quick piercing glance at this patch I'm inclined to believe that 
  this breaks other things like LVS-NAT and possibly asymmetric routing. 
While all of your patches are not likely to hit the vanilla 2.2.x kernel 
you might want to warn people using WOLK in conjunction with LVS-NAT and 
the cited patch above. YMMV of course and testing could prove me wrong.

Best regards,
Roberto Nibali, ratz

p.s.: I still haven't sent you my patches for the 2.2.x kernel ;)
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

