Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUK3B1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUK3B1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbUK3B1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:27:50 -0500
Received: from [210.77.38.126] ([210.77.38.126]:42117 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id S261921AbUK3B1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:27:48 -0500
Message-ID: <41ABCC42.4080400@turbolinux.com>
Date: Tue, 30 Nov 2004 09:26:26 +0800
From: bobl <bobl@turbolinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031231
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is this a bug of vt_ioctl ??
References: <41AAD28B.2070301@turbolinux.com> <20041129132615.0564c013.akpm@osdl.org>
In-Reply-To: <20041129132615.0564c013.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> bobl <bobl@turbolinux.com> wrote:
> 
>>we can see in the case PIO_UNIMAPCLR, One parameter of con_clear_unimp 
>>is  "fg_console"! it's current tty!  In the implement of 
>>do_unimap_ioctl(), use "fg_console" too! Use "console" will be right!
> 
> 
> This was fixed almost a year ago.
> 
> 
>>The attachment is a patch against 2.6.8.1.
> 
> 
> Maybe you're looking at a 2.4 kernel.
> 
Sorry!

It's my fault! What i am looking is 2.6.0!

So sorry!

Bob

