Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTFPAl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFPAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:41:26 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:47018 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263171AbTFPAlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:41:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Per Nystrom <pnystrom@netmagic.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
Date: Mon, 16 Jun 2003 10:55:13 +1000
User-Agent: KMail/1.5.2
References: <1055722972.1502.39.camel@spike.sunnydale>
In-Reply-To: <1055722972.1502.39.camel@spike.sunnydale>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306161055.13996.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003 10:22, Per Nystrom wrote:
> 2.4.21 crashes hard running cdrecord in X.
>
> I just compiled installed 2.4.21, and when I try to burn a cd in X,
> everything locks up hard.  I've enabled kernel debugging and set up a
> serial console to try to capture anything I can, but I don't even get a
> panic or an oops message.  The following line is the last dying gasp
> from syslogd:
>
> Jun 15 16:21:54 spike kernel: scsi : aborting command due to timeout :
> pid 569,
> scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00
>
> After that, everything is locked up hard.  Even the SysRq keys won't
> work.  The command I was running that particular time was
>
> cdrecord dev=0,0,0 blank=fast
>
> This only seems to happen when I'm running in X.  I can use cdrecord to
> burn cds all day when X is not running.  I haven't gotten any
> finer-grained with it than that; I don't know if it's X itself, the
> window manager, the desktop, nvidia's drivers, or any other bits that

Could you please try without the nvidia drivers. You will get no support here 
with them running. There is no way of knowing what happens when these are 
running. They have our source code, we don't have theirs.

Con

