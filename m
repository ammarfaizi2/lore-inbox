Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbVCKN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbVCKN3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVCKN3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:29:45 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:48374
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S263308AbVCKN3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:29:35 -0500
Message-ID: <42319D2D.7060402@ev-en.org>
Date: Fri, 11 Mar 2005 13:29:17 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabio Coatti <fabio.coatti@wseurope.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Simone Piunno <simone.piunno@wseurope.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bonnie++ uninterruptible under heavy I/O load
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111335.56782.vda@port.imtp.ilyichevsk.odessa.ua> <200503111420.52890.fabio.coatti@wseurope.com>
In-Reply-To: <200503111420.52890.fabio.coatti@wseurope.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti wrote:
> Alle 12:35, venerdì 11 marzo 2005, Denis Vlasenko ha scritto:
> 
>>>Unresponsiveness is not 2.6.11 specific (we've seen the same thing on
>>>2.6.10 and 2.6.8), not I/O scheduler specific ("as" and "deadline" behave
>>>the same) and not CPU/SMP specific (reproduced on single P4 HT and single
>>>P3), but only on these two DL585 servers we've seen bonnie++ resisting
>>>kill -9 for tens of seconds.
>>>
>>>Of course on request I can provide any other useful info.
>>>Any help is appreciated.
>>
>>I think Alt-SysRq-T will be interesting to see
> 
> Unfortunately this machine is on a remote location, so we don't have access to 
> keyboard. In some days we will be able to have a report of Alt-SysRq-T, but 
> until this  of course we can provide any information that can be gathered on 
> a remote shell.

echo t > /proc/sysrq-trigger

will do the job equivalently.

Baruch

