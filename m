Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUJFDIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUJFDIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJFDIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:08:24 -0400
Received: from [82.154.234.26] ([82.154.234.26]:36995 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S266775AbUJFDHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:07:43 -0400
Message-ID: <4163619C.4070600@vgertech.com>
Date: Wed, 06 Oct 2004 04:08:12 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patryk Jakubowski <patrics@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org> <41630B2C.5020709@interia.pl>
In-Reply-To: <41630B2C.5020709@interia.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patryk Jakubowski wrote:

...

> When I run it, the system (predictably) goes to ~100% CPU utilization,
> but there seems to be no way to find out who is hogging the CPU with
> top(1), ps(1), or anything else. All they can show is the main thread in
> zombie state, consuming 0% CPU.
> 
> Is this correct behaviour of linux?
> Would not this allow user space programs to hide running executions?
> This could be an opportunity for spyware to infect the machine and hide
> itself perhaps? Hope I'm wrong here!
> 
> If this is the bug in kernel (procfs?)  I can give you my configuration
> and resulting behaviour.

Yes, that's the new method trojans are using to hide tasks... No need to 
install complicated kernel modules anymore :-)

More seriously: That's a problem with current procps utils... They just 
don't show them. I can't complain too much because I'm not doing any 
code, but it would be nice to have a working top...

As a workaround, to at least see the threads without inspecting /proc 
directly, you can use the 'm' and 'H' flags to ps, i.e.

$ ps auwxH

Regards,
Nuno Silva

