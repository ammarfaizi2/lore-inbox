Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUBAHdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 02:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUBAHdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 02:33:54 -0500
Received: from terminus.zytor.com ([63.209.29.3]:65453 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265228AbUBAHdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 02:33:52 -0500
Message-ID: <401CABBF.20309@zytor.com>
Date: Sat, 31 Jan 2004 23:33:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: "Michael V. David" <michael@mvdavid.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: raid6 badness
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org.suse.lists.linux.kernel> <bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel> <p73ad44n7ig.fsf@verdi.suse.de> <401B421F.4060104@zytor.com> <Pine.LNX.4.58.0401310746320.9667@sapphire.newearth.org>
In-Reply-To: <Pine.LNX.4.58.0401310746320.9667@sapphire.newearth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael V. David wrote:
> 
> Done.
> 
> The patch applied, and the module raid6.ko compiled, with no problem.
> 
> The machine was rebooted because the crashed raid6.ko would not
> unload.
> 
> The new raid6.ko loaded and unloaded repeatedly without a problem.
> 
> I created a raid6 device with 6 components, and a file system, and it
> worked as expected, allowing failure of 1 or 2 component devices, but
> not 3.
> 
> At present, I have not tried building it into the kernel, and have not
> done any hard testing of raid6.
> 

Very cool, thanks.

	-hpa
