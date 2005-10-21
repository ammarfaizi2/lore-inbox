Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVJULDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVJULDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 07:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJULDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 07:03:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:2191 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964809AbVJULDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 07:03:18 -0400
Date: Fri, 21 Oct 2005 16:32:08 +0530
From: R Sharada <sharada@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: status of kexec for ppc on 2.6.10, any gotchas?
Message-ID: <20051021110208.GA3612@in.ibm.com>
Reply-To: sharada@in.ibm.com
References: <435876B8.9000706@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435876B8.9000706@nortel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Kexec support involves kernel level support per architecture and 
a user space kexec-tools.

	Generic kexec kernel support for ppc (ppc32/GameCube) was added 
sometime back by Albert Herranz, and I think they got included in 2.6.10-mm1 
as per:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1/broken-out/
	 Albert's code was also posted on this site:
http://www.gc-linux.org/down/isobel/kexec/
	ppc64 kexec kernel support was added recently (2.6.12-rc4-mm1)
	Eric's site can be used for downloading the kexec-tools.
	
	You may want to cross post kexec discussion mails to fastboot@osdl.org,
as that is the primary list where all kexec discussions happen.

Hope this helps
Thanks and Regards,
Sharada

On Thu, Oct 20, 2005 at 11:03:52PM -0600, Christopher Friesen wrote:
> 
> I've been asked to look at kexec for ppc on 2.6.10.  The syscall appears 
> to be present, but there seem to be additional patches for 2.6.10-mm at:
> 
> http://www.xmission.com/~ebiederm/files/kexec/
> 
> Are these patches needed?
> 
> I haven't been able to find any current official documentation, although 
> I found some old stuff from 2.5 and a writeup at:
> 
> http://www-128.ibm.com/developerworks/linux/library/l-kexec.html?ca=dgr-lnxw04RebootFast
> 
> Is there any official HOWTO on this?  Any issues I should look at in 
> particular?
> 
> Thanks for any pointers,
> 
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
