Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUAGT4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUAGT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:56:47 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:64417 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266327AbUAGT4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:56:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 7 Jan 2004 11:56:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jochen Hein <jochen@jochen.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0] Thinkpad 390E hangs after some time
In-Reply-To: <87ptdv60r5.fsf@echidna.jochen.org>
Message-ID: <Pine.LNX.4.44.0401071146140.2266-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Jochen Hein wrote:

> 
> I'm running 2.6.0 (and .1-rc1) on an IBM Thinkpad 390E with 196MB RAM.
> After some time - sometimes an hour or more, sometimes after a few
> minutes, performance suffers, the machine feels sluggish.  After some
> more minutes, the machine hangs.  No NMI-oopser, no ping, no panic
> LEDs blinking.

I had a very similar problem on two of my machines (CPQ laptop and IBM 
NetVista). The beast was completely random and it could have taken from 1 
hour to 48 hours to show up. Also, it seemed to be dependent on modules 
compiled in, even if not used. I couldn't get a decent oops log using NMI, 
serial console, lkcd of kgdb. Symptoms were about the same, there were a 
really short time where the machine was responsive and really sluggish 
(2-5 seconds), then absolute freeze. One time a have been able to get a 
partial SysRq+T, but the partial dump (only three tasks) did not show 
anything abnormal. Now, I cannot say that this is the cause, but building 
with 2.95.3 made my machines stable. But again, the thing was so random 
and so dependent on apparently unrelated things, that I am not sure than 
this is the cure. I was also thinking to be X related, but in my case it 
was not.




- Davide



