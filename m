Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbTEIQds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTEIQds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:33:48 -0400
Received: from watch.techsource.com ([209.208.48.130]:35785 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263307AbTEIQdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:33:45 -0400
Message-ID: <3EBBDC54.7070109@techsource.com>
Date: Fri, 09 May 2003 12:50:28 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: root@chaos.analogic.com, Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>	<Pine.LNX.4.53.0305070933450.11740@chaos>	<20030507135657.GC18177@wohnheim.fh-wedel.de>	<Pine.LNX.4.53.0305071008080.11871@chaos>	<p05210601badeeb31916c@[207.213.214.37]>	<Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>	<Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>	<Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>	<Pine.LNX.4.53.0305071547060.13869@chaos>	<3EB96FB2.2020401@techsource.com>	<Pine.LNX.4.53.0305080729410.16638@chaos>	<3EBA7AE2.9020401@techsource.com> <buou1c4v6oz.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miles Bader wrote:
> Timothy Miller <miller@techsource.com> writes:
> 
>>That is to say, some CPUs might have provision for a stack pointer to be 
>>associated with each interrupt vector.
> 
> 
> On my arch, the CPU doesn't use the stack for interrupts at all...
> so any saving on the stack is what's done by entry.S.
> 


Sure, but probably the majority are using x86 which would be affected by 
some of the ideas we've talked about in this thread.


