Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUKKWsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUKKWsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUKKWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:47:05 -0500
Received: from lists.us.dell.com ([143.166.224.162]:62119 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262405AbUKKWnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:43:46 -0500
Date: Thu, 11 Nov 2004 16:43:31 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Christian Kujau <evil@g-house.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041111224331.GA31340@lists.us.dell.com>
References: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de> <20041109234053.GA4546@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109234053.GA4546@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 05:40:54PM -0600, Matt Domsch wrote:
> OK, thanks, that helps.  From the diff of those dmesg:
> 
> -BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
> +BIOS EDD facility v0.16 2004-Jun-25, 6 devices found

As Linus points out, those are the magic numbers in EDD for number of
device entries stored.  Your BIOS seems to be reporting that is has
more devices than it does, or the EDD assembly is horked in a way I
have not yet deciphered.
 
> I'll review the assembly again to see where I could have miscounted,
> and see how that may affect the EDD sysfs exports.  Likely no answer
> from me before tomorrow though.

I haven't been able to find a solution to your problem yet, and given
some external time constraints I've got, won't be able to look into
this again for another week or more.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
