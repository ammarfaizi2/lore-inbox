Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbTCTTi0>; Thu, 20 Mar 2003 14:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbTCTTi0>; Thu, 20 Mar 2003 14:38:26 -0500
Received: from apollo.sot.fi ([195.74.13.237]:46345 "EHLO vscan.sot.com")
	by vger.kernel.org with ESMTP id <S261920AbTCTTiY>;
	Thu, 20 Mar 2003 14:38:24 -0500
Date: Thu, 20 Mar 2003 21:52:15 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace bug fix is not working!!!
In-Reply-To: <20030320192943.GE8256@gtf.org>
Message-ID: <Pine.LNX.4.44.0303202148050.30893-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Jeff Garzik wrote:

> On Thu, Mar 20, 2003 at 09:23:28PM +0200, Yaroslav Popovitch wrote:
> > Hi! I applied Alan Cox's patches for ptrace bug. But system is still 
> > exploitable.
> > 
> > I used my own kernel-2.4.19 with patch for 2.4.19 kernel. It does not 
> > helped. Then I took vanilla 2.4.20 kernel from www.kernel.org and applied 
> > patch for 2.4.20 kernel. System is still exploitable.
> 
> Can you verify that you are clearing the setuid bit that gets set, when
> the exploit is run?  IIRC, you must manually do that to verify that your
> system is indeed no longer exploitable.
> 
> 	Jeff
> 
Thanks, it helped ;). I did not delete and recompiled exploit from 
previous attempts, so it had SUID flag set. Thx.

 Sry for panic ...

Cheers,YP

> 
> 
> 

-
Mr. Yaroslav Popovitch yp@sot.com       - tel. +372 6419975
SOT Finnish Software Engineering Ltd.   - fax  +372 6419975
Kreutzwaldi 7-4, 10124  TALLINN         - http://www.sot.com
ESTONIA                                 - http://sotlinux.net

