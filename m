Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSHKWO4>; Sun, 11 Aug 2002 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSHKWOz>; Sun, 11 Aug 2002 18:14:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61450 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318426AbSHKWOz>; Sun, 11 Aug 2002 18:14:55 -0400
Message-ID: <3D56E2A9.40303@zytor.com>
Date: Sun, 11 Aug 2002 15:18:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Rob Landley <landley@trommello.org>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: klibc development release
References: <200208111820.g7BIKPd172856@saturn.cs.uml.edu> <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net> <20020811210406.GA27048@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
>>to one side: I'm not fond of glibc and am looking to replace it in my own 
>>system, but it hasn't made it to the top of my to-do list yet.  (Dietlibc is 
>>straight GPL: it can't even be the dynamic replacement for glibc in a real 
>>world linux distribution.  HPA suggested I look at newlibc, which I've added 
>>to my to-do list).
> 
> As far as I know, uClibc is the only library that is able to
> replace glibc for real world linux distributions...  And I've
> looked long and hard (which was why I ended up making uClibc),
> 

This, of course, is not a goal for klibc at all.  I looked at uclibc,
dietlibc, and newlib before starting klibc.  klibc is meant to be *tiny*
first of all, and is very much not designed to be able to compile
arbitrary programs.

	-hpa


