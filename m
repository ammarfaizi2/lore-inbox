Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTGFPvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTGFPve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:51:34 -0400
Received: from [65.248.106.250] ([65.248.106.250]:29903 "EHLO brianandsara.net")
	by vger.kernel.org with ESMTP id S262409AbTGFPvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:51:33 -0400
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: gigag@bezeqint.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 3.5/0.5 address space split
Date: Sun, 6 Jul 2003 11:07:28 -0500
User-Agent: KMail/1.5.2
References: <3927aea9.9f3cdaec.8177f00@mas3.bezeqint.net>
In-Reply-To: <3927aea9.9f3cdaec.8177f00@mas3.bezeqint.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061107.28106.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would try to use the whole aa patchset, I'm using the 3.5/0.5 split on one 
of the servers at work and it handles it fine with the whole aa patchset.

--Brian Jackson

On Sunday 06 July 2003 11:00 am, gigag@bezeqint.net wrote:
> >As far as I remember I saw some places in the code which
> >should be fixed before split 1/3 can be used. Split 0.5/3.5 can be
> >not-working if you are using PAE-enabled kernel (in some places
> >pgds are copied directly - i.e. 1GB granularity is used).
>
> Right. I've seen a mention on this all over the Net.
>
> Anyway, I'm not using PAE since I have only 4GB of real memory.
> Also, I'm using a patch obtained at
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2
> .4.20pre5aa1/00_3.5G-address-space-5
>
> I need this split to be able to fully utilize the memory for my
> application, which I hope will work. Are you working on the patch
> for 2.4 or 2.5 kernel?
>
> Could anybody suggest a configuration what is working?
>
> Thanks
> Giga
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net

