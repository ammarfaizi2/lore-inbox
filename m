Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVHOMWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVHOMWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVHOMWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:22:17 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:39548 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbVHOMWQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ebhlNX/Z8vZyo8pu3tFe49IWeAvgcJ6/noscxgCQc2Fi0DlQgSI+dizT+8vVxNi88mL/4f6oc/AIUWSD3/HkcGZ6+PCpxuMMadswlrySdn7itwqMfIY4RzuS0pzbiEKVZ4wBwBi3UqEb9aYBdYjwEYaRLB5P1ySacjfiZXnDJK0=
Message-ID: <9a8748490508150522f6c3921@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:22:12 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "D. ShadowWolf" <dhazelton@enter.net>
Subject: Re: oops in 2.6.13-rc6-git5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508150133.49400.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508150133.49400.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, D. ShadowWolf <dhazelton@enter.net> wrote:
> Decided to take the latest git kernel for a run and ran into the following oops when shutting the system down to try it from a cold-boot situation. I wasn't able to capture the oops as it happened, but thankfully syslog was still running and I managed to trap it there.
> 

serial console, netconsole, console on line-printer  are all useful
for capturing Oops data. There are detailed guides in Documentation/

> When the oops occurred the system was almost shut down, but the command that was executing at the time was to save the sync the hardware clock to Linux (I think)... the trap from my kernel logs (I have each class of kernel event redirected to a different file. This leads to some huge files in a short span, but is useful for debugging a new kernel)
> The kernel is tainted by the lt modem drivers (lt_modem & lt_serial) however the problem does not appear to be in either of those, and they function properly under 2.6.12.3
> 
> I'm running a basic Slackware 10 distribution (other than the ltmodem drivers (gone inside the next month))
> 

I've tried to reproduce the Oops here with your config, but my
hardware is too different to match your config, so I had to make some
changes to get the kernel running. In the end I was not able to
reproduce it.

Can you reproduce the crash reliably? 
Can you reproduce the crash with a non-tainted kernel?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
