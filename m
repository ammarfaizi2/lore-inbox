Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWGEOZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWGEOZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGEOZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:25:29 -0400
Received: from main.gmane.org ([80.91.229.2]:43662 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964872AbWGEOZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:25:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc D Ronell <mronell@alumni.upenn.edu>
Subject: Re: CONFIG for udev to work?
Date: Mon, 03 Jul 2006 21:47:20 -0400
Message-ID: <871wt23zvb.fsf@corps.glidepath.invalid>
References: <200607040332.48506.romit.linux@gmail.com> <6bffcb0e0607031514r6e14c68am5964f07265e0caeb@mail.gmail.com>
 <200607040357.14123.romit.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: romit.linux@gmail.com
X-Gmane-NNTP-Posting-Host: dialup-4.156.42.193.dial1.boston1.level3.net
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:g6+P7RtjpWEy97hN6VQWjm5AFH8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romit <romit.linux@gmail.com> writes:

> Hi Michal,
>              Thanks. I checked the udev version and it is 068. Meanwhile, what 
> I did was I booted into 2.6.13-15 and
> zcat /proc/config.gz > $(KERN_SOURCEDIR_2.6.17.1)/
> and then ran 
> make xconfig.
>
> Ofcourse there were some CONFIG options that were present in 2.6.13-15 and 
> missing in 2.6.17.1 and vice versa but once I resolved those and built the 
> kernel, udev seems to be working. So I did not upgrade udev to 071 but still 
> it works. I think there should be some CONFIG option that I am missing. I am 
> not sure which one. 
> Thanks again,
> -Romit
>

What  version  of  /lib/libsysfs  are  you using?   I  think  udev  is
dependent on this library.  Perhaps an upgrade will help.

Marc

