Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317771AbSGKHnu>; Thu, 11 Jul 2002 03:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSGKHnu>; Thu, 11 Jul 2002 03:43:50 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:32690 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317771AbSGKHnt>; Thu, 11 Jul 2002 03:43:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: fdavis@si.rr.com
Subject: Re: [PATCH] 2.5.25 : tr_source_route fix
Date: Thu, 11 Jul 2002 11:46:30 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207101011580.873-100000@localhost.localdomain> <200207101548.g6AFmUg96842@d12relay01.de.ibm.com> <3D2C64AF.6020102@si.rr.com>
In-Reply-To: <3D2C64AF.6020102@si.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207111134.34672.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 July 2002 18:45, Frank Davis wrote:

>     I have a few questions regarding your patch. I don't see the line
> you are removing from net/netsyms.c in 2.5.25 , and for
> net/llc/llc_mac.c , I also don't see where trdevice.h would be included
> to make the reference to tr_source_route . Thanks.

Sorry for the confusion, I was in the wrong branch of my repository when I did 
the diff.
trdevice.h should be added to the includes in net/llc/llc_mac.c when removing
the declaration and net/netsyms.c does indeed not have that line. 

	Arnd <><
