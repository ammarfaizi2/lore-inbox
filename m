Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUBQEk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUBQEk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:40:28 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:6851 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S265977AbUBQEk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:40:27 -0500
Message-ID: <40319B49.1070006@myrealbox.com>
Date: Mon, 16 Feb 2004 20:40:41 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] usblp_write spins forever after an error
References: <402FEAD4.8020602@myrealbox.com> <20040216035834.GA4089@kroah.com>
In-Reply-To: <20040216035834.GA4089@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was 2.6.1 vanilla.

--Andy

BTW, these aren't going to linux-usb-devel because myrealbox.com fails 
verification.  I emailed them -- hopefully they'll fix it soon.

Greg KH wrote:
> On Sun, Feb 15, 2004 at 01:55:32PM -0800, Andy Lutomirski wrote:
> 
>>I recently cancelled a print job with the printer's cancel function, and 
>>the CUPS backend got stuck in usblp_write (using 100% CPU and not 
>>responding to signals).
> 
> 
> What kernel are you referring to here?
> 
> thanks,
> 
> greg k-h
