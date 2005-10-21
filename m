Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVJUKbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVJUKbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVJUKbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:31:25 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:7777 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932559AbVJUKbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:31:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S0a7OW3mnM1RADUCRPwU28czrp8zWL+4Hkf0oxwpW+D2YiJfBqO210FS1lsCyublKkjpol81Fc/yA2JtCX7u754GU1L8IR3C2RZ2MbNJ7TFKcC1/0J1kqLOZo4sotEHdKyqBiHfNFdfyYAyeyHXA/iKs2gWYAh5zTFzO3vMl4cc=
Message-ID: <9a8748490510210331o73b44adr8b3c2f613a3af490@mail.gmail.com>
Date: Fri, 21 Oct 2005 12:31:24 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Emmett Lazich <elazich@hutchison.com.au>
Subject: Re: oops on SUSE LES9-SP2-smp on dual EM64T processor system
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129871849.10237.22.camel@poppy.syd.hutch.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129871849.10237.22.camel@poppy.syd.hutch.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Emmett Lazich <elazich@hutchison.com.au> wrote:
> Posting to you after reading Documentation/oops-tracing.txt
> I am still looking into how to report this fault to SUSE.

Call your SuSE representative I'd say would be a pretty good first step.
SuSE/Novell have plenty of support options listed on their website,
shouldn't be hard to find the right contact info.


> After this oops, the machine kept running (phew!), however these

Don't put too much trust in the machine after the kernel has Oopsed.
It may appear to run, but most likely something is badly wrong in
kernel land at this point, so anything could happen - I'd say reboot
that machine as soon as you are able to.

> processes hang: ps, top, w.  However vmstat, iostat and uptime still
> work ok. uptime says machine has a load average of around 20, but vmstat
> and iostat say machine is near idle. We will reboot it with nosmp until
> this fault is better understood.
>
> dmesg output:
> general protection fault: 0000 [1] SMP
> CPU 3
> Pid: 26432, comm: ps Not tainted (2.6.5-7.191-smp

2.6.5 is a pretty darn old kernel by now. First thing I would
personally do would be to go to kernel.org, grab a 2.6.13.4 kernel
source, build that, then try to reproduce the problem. An enourmous
amount of fixes have happened since 2.6.5.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
