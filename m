Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUCFOob (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUCFOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:44:31 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:45027 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S261676AbUCFOo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:44:29 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
Subject: Re: Badness in pci_find_subsys at drivers/pci/search.c:167
Date: Sat, 6 Mar 2004 14:47:52 +0000
User-Agent: KMail/1.6
References: <40498A7F.5070306@uni-paderborn.de> <521xo6xtn0.fsf@topspin.com> <4049913E.8090600@uni-paderborn.de>
In-Reply-To: <4049913E.8090600@uni-paderborn.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403061447.53012.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 March 2004 08:52, you wrote:
> Roland Dreier schrieb:
> >     Bjoern> Is there a possibility to find out which device caused
> >     Bjoern> this error?  It's the first time that it has been
> >     Bjoern> arisen...  The kernels version is v2.6.3, do you need more
> >     Bjoern> "input"?
> >
> > This is caused by the closed source nvidia driver.  Only nvidia can
> > debug this problem.
> >
> >  - Roland
>
> Thank you for your answer. Is that a known bug? If not then i'll
> send a bug report to nvidia.

Generally, it's a good idea to search the LKML archives (via 
marc.theaimsgroup.com or google group search) for your problem before 
posting, to see if it has already been reported.

For future reference, oopsen containing the _nvXX symbols are NVIDIA driver 
specific problems and should not be reported to this list.

This problem is well known and is trivially fixed, I am confident NVIDIA are 
already aware of it and it will be repaired in the next revision of the 
driver.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
