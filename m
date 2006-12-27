Return-Path: <linux-kernel-owner+w=401wt.eu-S1753633AbWL0RwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbWL0RwF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbWL0RwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:52:04 -0500
Received: from web32601.mail.mud.yahoo.com ([68.142.207.228]:40778 "HELO
	web32601.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753635AbWL0RwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:52:03 -0500
X-YMail-OSG: .RkP7n4VM1nh15M0LJPC8vjMeOJLWlR9nHyFxzn8m3wKxYEro75jCxXlYdnVYJ0O.5CxkCM_vcTeU3BCGaMWZDYBAo2rp0hHztr.mqOtX_2.N71SvT3Qfw--
X-RocketYMMF: knobi.rm
Date: Wed, 27 Dec 2006 09:52:02 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
To: linux-kernel@vger.kernel.org
In-Reply-To: <1167235772.3281.3977.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <681548.1013.qm@web32601.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In article <1167235772.3281.3977.camel@xxxxxxxxxxxxxxxxxxxxx> you
wrote:
>> once your program (and many others) have such a check, then the next
>> step will be pressure on the kernel code to "fake" the old situation
>> when there is a processor where <vague criteria of the day> no
longer
>> holds. It's basically a road to madness :-(
>
> I agree that for HPC sizing a benchmark with various levels of 
> parallelity are better. The question is, if the code in question
> only is for inventory reasons. In that case I would do something
> like x sockets, y cores and z cm threads.
>
> Bernd

 For sizing purposes, doing benchmarks is the only way. For the purpose
of Ganglia the sockets/cores/threads info is purely for inventory. And
we are likely going to add the new information to our metrics.

 But - we still need to find a way to extract the infor :-)

Cheers
Martin
PS: I have likely killed the CC this time. Sorry.

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
