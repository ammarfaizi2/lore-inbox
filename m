Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753165AbVHHAxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbVHHAxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbVHHAxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:53:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753165AbVHHAxQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:53:16 -0400
Date: Sun, 7 Aug 2005 17:52:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Um9n6XJpbw==?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1
Message-Id: <20050807175203.6b0edcde.akpm@osdl.org>
In-Reply-To: <20050808004537.GA20109@ime.usp.br>
References: <20050807014214.45968af3.akpm@osdl.org>
	<20050808004537.GA20109@ime.usp.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> Thanks Andrew, for including the vfat speedup patch.
> 
> It has really improved a lot the performance of access to directories
> having many subdirectories in an external Firewire HD that I have.
> 
> I'd say that if others don't have problems with it, then it should be
> in 2.6.13, as far as I am concerned.

It's probably a bit late to be able to determine that.  This one's 2.6.14
material, sorry.

> BTW, everything is working fine with the sbp2/ieee1394 drivers that
> are in the mm tree.

Good to hear.

> It seems that there are some issues with ALSA, though. I will report
> back as soon as I see if these are userland problems or not (it worked
> fine with vanilla 2.6.13-rc5).

OK, thanks for testing and reporting.  Our turnaround time for ALSA fixes
is not fantastic, really, so any problems which we currently have will
probably carry over into 2.6.13.  If you can raise a bugzilla record for
any problems in -rc6 I'll make sure they aren't forgotten.
