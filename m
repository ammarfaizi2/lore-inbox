Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUCJSHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUCJSFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:05:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262736AbUCJSEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:04:39 -0500
Message-ID: <404F58A8.8040304@pobox.com>
Date: Wed, 10 Mar 2004 13:04:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, James.Smart@Emulex.com,
       linux-scsi@vger.kernel.org
Subject: Re: [Announce] Emulex LightPulse Device Driver
References: <3356669BBE90C448AD4645C843E2BF2802C014D7@xbl.ma.emulex.com>	<mailman.1078908361.15239.linux-kernel2news@redhat.com> <20040310095908.33b2082f.zaitcev@redhat.com>
In-Reply-To: <20040310095908.33b2082f.zaitcev@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> Flag problem on sparc is fixed by Keith Wesolowsky for 2.6.3-rcX,
> and it never existed on sparc64, which keeps CWP in a separate register.
> 
> Why it took years to resolve is that the expirience showed that
> there is no legitimate reason to pass flags as arguments. Every damn
> time it was done, the author was being stupid. Keith resolved it
> primarily because it was an unorthogonality in sparc implementation.

You would never know there were so many sparc people, until I post 
something incorrect about it.  <grin>

I stand corrected.  As someone mentioned in private, it's actually a 
shame that was fixed, since that's one less argument that can be used 
against such wrappers ;-)


>>But this bug is only an example that serves to highlight the importance 
>>of directly using Linux API functions throughout your code.  It may 
>>sound redundant, but "Linux code should look like Linux code."  This 
>>emphasis on style may sound trivial, but it's important for 
>>review-ability, long term maintenance, and as we see here, bug prevention.
> 
> 
> Yes yes yes. This is the way elx_sli_lock is harmful, not because
> of its passing flags.

Agreed.

	Jeff



