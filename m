Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWBGBfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWBGBfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWBGBfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:35:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964799AbWBGBft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:35:49 -0500
Date: Mon, 6 Feb 2006 17:35:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <safemode@comcast.net>
Cc: safemode@comcast.net, alan@lxorguk.ukuu.org.uk, harald.dunkel@t-online.de,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
Message-Id: <20060206173520.43412664.akpm@osdl.org>
In-Reply-To: <43E7F73E.2070004@comcast.net>
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
	<43E3D103.70505@comcast.net>
	<Pine.LNX.4.58.0602060836520.1309@shark.he.net>
	<43E7A4C0.4020209@t-online.de>
	<1139255800.10437.51.camel@localhost.localdomain>
	<43E805D4.5010602@comcast.net>
	<43E7F73E.2070004@comcast.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <safemode@comcast.net> wrote:
>

(eek, top-posting!)

> 2.6.16-rc2 with the libata patch alan cox provided resulted in a system 
> which correctly found my atapi drive on the pata bus.  
> 
> Also, moving from the mm kernels to 2.6.16-rc2 resulted in my pm timer 
> working again. 

I don't recall that.  Even 2.6.16-rc1-mm5?  What about rc1-mm4?

> So, it may have been all along that libata had supported my atapi 
> device, but either the patch when it got merged with mm became broken or 
> something else in mm broke it, and something else in mm caused my pm 
> timer to stop being used. 
> 
> Hopefully more people chime in with issues like this so the bug can be 
> tracked down in mm before the offending code makes it's way to a regular 
> release. 
> 
> 
> Also just to note, the patch to 2.6.16-rc2 alan cox made switches the 
> load order of pata and sata from mm, resulting in device name changes.  

That's bad.

