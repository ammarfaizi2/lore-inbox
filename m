Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUHIQJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUHIQJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUHIQHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:07:43 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:14743 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S266703AbUHIQCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:02:13 -0400
Date: Mon, 09 Aug 2004 12:00:11 -0400
From: consolebandit@netscape.net (Maurice)
To: vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.xSMP and IPv4 issues (ifconfig(s))
MIME-Version: 1.0
Message-ID: <5D229985.7782B8C2.345005B1@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 169.244.70.148
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

>
>You should connect your box to another one and verify that
>network is ok (it is working under non-SMP kernel, right?).
>Most probably you already did this. :)
>
>Then, do this ping test again, and while ping is running, do
>
>tcpdump -nleieth0 -s0 -vvv
>
>on both boxes. You will see what is happening on the wire.
>For example, does other box actually hear anything?
>
>> New! Netscape Toolbar for Internet Explorer
>
>Heh.
>--
>vda
>
>

Not to switch gears on you, but...

I have a "fix", through some feedback from the fedora-legacy-project list I was directed to send the command 'noapic' at boot time.  To see if this would have some effect on the IPv4 problem.

This allowed IPv4 to operate with the SMP kernel!!!

So, can anyone explane what is going on with this...
Is it my motherboard/bios having communication issues with the SMP kernel, but not with the non-SMP kernel?

Thanks, Denis, for you assistance with this issue.


--------
-Maurice

"Linux -- it not just for breakfast anymore..."
-Moe



__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
