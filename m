Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWFHSjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWFHSjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWFHSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:39:10 -0400
Received: from rtr.ca ([64.26.128.89]:17861 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964932AbWFHSjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:39:09 -0400
Message-ID: <4488368B.5070103@rtr.ca>
Date: Thu, 08 Jun 2006 10:39:07 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
Cc: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: booting without initrd
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com> <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
In-Reply-To: <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:
>
> AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
> grub.conf and therefore needs the initrd in order to work correctly.
> If you do not want an initrd, then change this to
> "root=/dev/<your_disk>" in grub.conf. Note that the reason Fedora uses
> the LABEL is so you can move disks around in your system without a problem

Heh.. except for people like me, who regularly swap disks around
to boot from different distros, in which case the LABEL=/ continuously
causes nothing but grief until I remember to edit it away.

Cheers
