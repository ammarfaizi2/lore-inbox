Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318462AbSGSIJz>; Fri, 19 Jul 2002 04:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318463AbSGSIJz>; Fri, 19 Jul 2002 04:09:55 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:62859 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318462AbSGSIJz>; Fri, 19 Jul 2002 04:09:55 -0400
Date: Fri, 19 Jul 2002 10:12:43 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Yann Dirson <ydirson@altern.org>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: Generic modules documentation is outdated
Message-ID: <20020719081243.GA6311@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Yann Dirson <ydirson@altern.org>, linux-kernel@vger.kernel.org,
	kaos@ocs.com.au
References: <20020704212240.GB659@bylbo.nowhere.earth> <20020718210259.GJ19580@bylbo.nowhere.earth> <1027032521.8154.48.camel@irongate.swansea.linux.org.uk> <20020718232535.GB8165@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718232535.GB8165@bylbo.nowhere.earth>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 01:25:35AM +0200, Yann Dirson wrote:

> Hm, no, I found the real one (although HFS has the problem):
> 
> # modprobe ppp_deflate
> Warning: loading /lib/modules/2.4.18+preempt/kernel/drivers/net/ppp_deflate.o will taint the kernel: non-GPL license - BSD without advertisement clause

biwa:~/kernel/linux-2.4 9 > grep MODULE_LICENSE fs/hfs/* drivers/net/ppp_deflate.c 
fs/hfs/super.c:MODULE_LICENSE("GPL");
drivers/net/ppp_deflate.c:MODULE_LICENSE("Dual BSD/GPL");

These are in 2.4.19-rc2.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
