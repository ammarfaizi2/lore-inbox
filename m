Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbULGVMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbULGVMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbULGVMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:12:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:30339 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261935AbULGVMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:12:25 -0500
Message-ID: <41B612F8.501@osdl.org>
Date: Tue, 07 Dec 2004 12:30:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: werner@sgi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC]Add an unlocked_ioctl file operation
References: <200412071211.41468.werner@sgi.com>
In-Reply-To: <200412071211.41468.werner@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Werner wrote:
> Per Andi Kleen's suggestion.
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> #   Run Lindent on ioctl.c
> #   Add an ioctl path which does not take the BKL.

Isn't there some commentary around about one patch per email?
Please read
   http://linux.yyz.us/patch-format.html
and
   http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Also there was an email from Linus last week in the loooooong
"splitting kernel headers" thread about this.  In particular,
about doing lindent patches completely standalone.

That way we can review each patch on its own merit.

Thanks.
-- 
~Randy
