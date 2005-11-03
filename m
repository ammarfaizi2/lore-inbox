Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVKCPSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVKCPSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCPSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:18:38 -0500
Received: from scifi.dolphinics.no ([193.71.152.62]:22662 "EHLO
	poesci.dolphinics.no") by vger.kernel.org with ESMTP
	id S1030265AbVKCPSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:18:37 -0500
Message-ID: <436A29D4.1080700@dolphinics.no>
Date: Thu, 03 Nov 2005 16:16:36 +0100
From: Simen Thoresen <simentt@dolphinics.no>
Organization: Dolphin ICS
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simen Thoresen <simentt@dolphinics.no>
Cc: Devesh Sharma <devesh28@gmail.com>, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: Issues in Booting kernel 2.6.13
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>	 <20051006190806.388289ff.rdunlap@xenotime.net>	 <43481D0F.9020407@dolphinics.no>	 <20051008123131.41d85d45.rdunlap@xenotime.net>	 <434A23A2.1020407@dolphinics.no>	 <309a667c0510100215wcf311bcr3cc0555cc4557d39@mail.gmail.com> <309a667c0510100228s5c9bac7cwaf74548520bba808@mail.gmail.com> <434A38D0.9040103@dolphinics.no>
In-Reply-To: <434A38D0.9040103@dolphinics.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simen Thoresen wrote:
> Hi Devesh,
> 
> I still have problems, and I see both mptbase and mptscsih loading, so 
> I've assumed that mkinitrd is not happy with the new kernel.
> 
> Could you please mail me your .config directly so I can have a look at it?
> 
> -S

Hi Devesh, Randy

Sorry about not following this up earlier, but I've resolved my problem, and 
am booting happily. CONFIG_FUSION_SPI=y (rather than =m), and then tell 
mkinitrd not to care about scsi-devices.

Than you for your help :-)

Yours,
-S
-- 
Simen Thoresen, Wulfkit Support, Dolphin ICS
http://www.tysland.com/~simentt/cluster
