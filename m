Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbRGILcF>; Mon, 9 Jul 2001 07:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbRGILb5>; Mon, 9 Jul 2001 07:31:57 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59805 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S267032AbRGILbo>; Mon, 9 Jul 2001 07:31:44 -0400
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091315190.278-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
Date: 09 Jul 2001 13:30:57 +0200
In-Reply-To: <Pine.LNX.4.33.0107091315190.278-100000@mikeg.weiden.de>
Message-ID: <m3r8vq8hla.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, 9 Jul 2001, Mike Galbraith wrote:
>> > But still this may be a hint.
> 
> _Anyway_, tmpfs is growing and growing from stdout.  If I send
> output to /dev/null, no growth.  Nothing in tmpfs is growing, so I
> presume the memory is disappearing down one of X or KDE's sockets.

So tmpfs is not growing, but you still have a mem leak only with
tmpfs? Is there some deleted file allocating blocks? Or did
redirecting stdout fix the problem. I am not sure that I understand
the situation.

> No such leakage without tmpfs, and I can do all kinds of normal
> file type use of tmpfs with no leakage.

BTW I am running /tmp on tmpfs all the time with KDE and never
experienced something like that. But of course I ran oom without size
limits.

Greetings
		Christoph


