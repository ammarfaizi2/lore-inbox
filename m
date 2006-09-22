Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWIVS1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWIVS1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWIVS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:27:24 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:58035 "EHLO
	smtp131.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S964864AbWIVS1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:27:23 -0400
Message-ID: <45142B0F.2090304@gentoo.org>
Date: Fri, 22 Sep 2006 14:27:27 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Tom St Denis <tomstdenis@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>	 <4513D362.8030804@gentoo.org>	 <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>	 <450E4C25.9030206@gentoo.org> <bd0cb7950609220929j55c24230h4e53db34af0ac385@mail.gmail.com>
In-Reply-To: <bd0cb7950609220929j55c24230h4e53db34af0ac385@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom St Denis wrote:
> No, i get sky2 printk after udev kicks in.  It was a 2.6.17-gentoo-r8
> kernel which has devices 4364 through 4368 [just checked].

So your 2.6.17 kernel *is* modified :)

> This means my patch is incomplete, and the fix Gentoo made against
> 2.6.17 didn't make it into 2.6.18.  ARRG.

I maintain the Gentoo kernel and yes we do include sky2 changes, 
sometimes before they make it to Linus for whatever reason, but always 
only if they are in the netdev tree.

If you had switched from gentoo-sources-2.6.17 to gentoo-sources-2.6.18 
you would not have noticed any loss of functionality since the patches 
are obviously carried across. The difference appears to be that you went 
from gentoo-2.6.17 to vanilla-2.6.18...

Daniel
