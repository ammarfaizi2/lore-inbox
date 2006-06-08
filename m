Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWFHUJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWFHUJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWFHUJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:09:19 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:7651 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964961AbWFHUJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:09:17 -0400
Date: Thu, 8 Jun 2006 10:58:14 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Mark Lord <lkml@rtr.ca>
cc: Rahul Karnik <rahul@genebrew.com>, Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: booting without initrd
In-Reply-To: <4488368B.5070103@rtr.ca>
Message-ID: <Pine.LNX.4.63.0606081057100.1833@qynat.qvtvafvgr.pbz>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com> 
 <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com> <4488368B.5070103@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Mark Lord wrote:

> Rahul Karnik wrote:
>> 
>> AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
>> grub.conf and therefore needs the initrd in order to work correctly.
>> If you do not want an initrd, then change this to
>> "root=/dev/<your_disk>" in grub.conf. Note that the reason Fedora uses
>> the LABEL is so you can move disks around in your system without a problem
>
> Heh.. except for people like me, who regularly swap disks around
> to boot from different distros, in which case the LABEL=/ continuously
> causes nothing but grief until I remember to edit it away.

not to mention the fact that the label checking code only checks the first 
several drives (I don't know how  many, but I know that it won't find a 
label on sdq :-)

David Lang
