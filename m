Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVHDV2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVHDV2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVHDV0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:26:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262717AbVHDVYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:24:06 -0400
Date: Thu, 4 Aug 2005 14:25:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: pavel@suse.cz, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
Message-Id: <20050804142548.5b813700.akpm@osdl.org>
In-Reply-To: <42DD67D9.60201@stud.feec.vutbr.cz>
References: <42DD67D9.60201@stud.feec.vutbr.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>
> Hello,
> 
> Does resuming from swsuspend work for anyone with amd64-agp loaded?

It would seem not ;)

> On my system when I suspend with amd64-agp loaded, I get a spontaneous 
> reboot on resume. It reboots immediately after reading the saved image 
> from disk.
> This is 100% reproducible.
> 
> Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.

If this is reproducible in the soon-to-be-released 2.6.13-rc6 then could
you please raise an entry at bugzilla.kernel.org and we'll plug away at it
as the suspend stuff continues to get sorted out, thanks.

