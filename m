Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVADG0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVADG0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 01:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVADG0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 01:26:19 -0500
Received: from mx.freeshell.org ([192.94.73.21]:11738 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262207AbVADG0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 01:26:12 -0500
Date: Tue, 4 Jan 2005 06:26:07 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501040117.28803.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501040621110.25801@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <d120d50005010308355783c996@mail.gmail.com> <Pine.NEB.4.61.0501040543490.25801@sdf.lonestar.org>
 <200501040117.28803.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ya know what, I haven't tried any of the 2.6.8 kernels at all, so maybe 
for that binsearch I could start at 2.8-final? All this, of course after 
testing a full powercycle, as you suggested.

And another thing.. something with libata doesn't jive right with my 
sata drives.  I have 2x74 GB SATA western digital raptors in a Raid 1 
configuration, and it panics if I don't use the pre-libata drivers. I'll 
write up another post about this one -- maybe I'll ask Jeff 
Garzik about this, too, as he works on libata.


Thanks,
- Roey


On Tue, 4 Jan 2005, Dmitry Torokhov wrote:

> Ok, it looks that the big input update is not to blame. Just to make sure
> could you re-run the tests with -bk3 and -bk4 but with powering the box
> down instead of simply rebooting to ensure that noth kernels get completely
> fresh start. If keyboard still does not work I am afraid you will have to
> resort to binary search to figure out which 2.6.9-*-bk is at fault.
>
> -- 
> Dmitry
>
