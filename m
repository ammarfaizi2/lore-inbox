Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVIOPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVIOPZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVIOPZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:25:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030494AbVIOPZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:25:28 -0400
Date: Thu, 15 Sep 2005 11:30:03 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Rajat Jain <rajat.noida.india@gmail.com>
cc: Linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problem booting 2.6.13 on RHEL 4
In-Reply-To: <b115cb5f05091321082a3ffc24@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0509151124420.15025@dhcp83-105.boston.redhat.com>
References: <b115cb5f05091321082a3ffc24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Sep 2005, Rajat Jain wrote:

> Hi list,
> 
> I am using RHEL4 distribution, and am trying to boot with vanilla
> 2.6.13 stock kernel. My system has two onboard Adaptec SCSI
> controllers. I am booting using initrd, and passing the correct
> "root=" option. The following message pops up while trying to boot
> with 2.6.13:
> 

it might be worth trying an updated 'mkinitrd'. The one currently in rhel4 
can currently do parallel 'insmod's, which might be causing this issue. 
See bugzilla: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=145660 
for more detail. This is fixed in U2, which isn't quite shipping yet, but 
in the meantime, I think you can get the updated package from the U2 beta 
channel.

thanks,

-Jason 
