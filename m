Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbVIPC5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVIPC5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 22:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbVIPC5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 22:57:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32219 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030543AbVIPC5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 22:57:21 -0400
Message-ID: <432A348D.40906@pobox.com>
Date: Thu, 15 Sep 2005 22:57:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkosewsk@gmail.com
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc1 0/3] Add disk hotswap support to libata RESEND
 #3
References: <355e5e5e050914220444505b09@mail.gmail.com>
In-Reply-To: <355e5e5e050914220444505b09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> Hello Jeff, all,
> 
> Another attempt at hotswap support to libata... this would be attempt #3.
> 
> Lots of improvements... a cleaner API, clean straightforward code
> which is easy to customize (or generalize, when the desire to support
> ATA hotswap comes along), and a new feature; no longer kernel panics
> on any action!
> 
> Some testing on x86 UP, minimal on SMP.  Please test, send questions,
> suggestions, and apply if you like it.  Patches apply cleanly to
> 2.6.14-rc1.  I've got some hardware so if you discover problems I can
> probably reproduce them.

At a really quick glance, looks positive to me.  Thanks for working on 
this!  Once this is merged, I'm sure users will thank you too:  people 
will be able to [literally] yank their disks, if they are failing, 
without bringing down the system.

I'm away this weekend, so won't be able to give it an in-depth look 
until next week.

	Jeff



