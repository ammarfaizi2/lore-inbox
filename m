Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSDJGX7>; Wed, 10 Apr 2002 02:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSDJGX6>; Wed, 10 Apr 2002 02:23:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24845 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312466AbSDJGX6>; Wed, 10 Apr 2002 02:23:58 -0400
Message-Id: <200204100620.g3A6KnX04868@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Brian Beattie <alchemy@us.ibm.com>,
        Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Event logging vs enhancing printk
Date: Wed, 10 Apr 2002 09:24:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Martin@m3.polymtl.ca,
        "Martin.Bligh@us.ibm.com" <J.Bligh@m3.polymtl.ca>,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, karym@opersys.com,
        lmcmpou@lmc.ericsson.se, lmcleve@lmc.ericsson.se
In-Reply-To: <m2it71uf4u.fsf@m3.polymtl.ca> <1018385394.7923.26.camel@w-beattie1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 April 2002 18:49, Brian Beattie wrote:
> I would prefer to see effort expended on fixing printk/klogd...off the
> top of my head:
>
> - make printk a macro that prepends file/function/line to the message.
> - fix printk calls: messages with consistent format, calls in the right
> places, with the "correct" information.
> - postprocessing tools for analysing the logs.
>
> I would say that this is probably less work than implementing evlog,
> much less work to maintain, and provide generally better performance.

Sounds ok for me.

It will be difficult to push it into mainline kernel.
I tried to fix loglevels in some printks. Patches were _trivial_
but nevertheless they weren't taken.
--
vda
