Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVLUSRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLUSRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVLUSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:17:18 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:8452 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932487AbVLUSRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:17:18 -0500
Date: Wed, 21 Dec 2005 19:19:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Gene Heskett <gene.heskett@verizononline.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-Id: <20051221191955.408c5151.khali@linux-fr.org>
In-Reply-To: <20051220151616.c8bdc00c.akpm@osdl.org>
References: <200512201505.43199.gene.heskett@verizon.net>
	<20051220151616.c8bdc00c.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

> Gene Heskett <gene.heskett@verizon.net> wrote:
>
> > To whomever is in charge of the sensors code in the kernel:
> > 
> > I just noted that the temperatures being reported by gkrellm, using its 
> > internal sensors stuff, are not correct by over 100F too low when -rc6 
> > is running.  -rc5 seems to give good readings consistent with what 
> > I've been observing for the last year, a slowly rising cpu reading due 
> > to the zallman flower becoming dust packed, to the point of about 150F 
> > for a normal reading.
> > 
> > Today, after rebooting to -rc6, I'm seeing cpu temps ranging between 
> > 39.2 and 41.7 degress F. As the room is probably around 74F, thats a 
> > bit of a dubious reading.
> > 
> > Whom do I contact about this? 
> 
> Jean.

No hwmon driver was updated between 2.6.15-rc5 and 2.6.15-rc6.

Are you getting the temperature value from ACPI, or from a hwmon
driver? If the latter, which driver is this, and which hardware
monitoring chip do you have?

-- 
Jean Delvare
