Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUJDD6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUJDD6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 23:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUJDD6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 23:58:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28819 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268370AbUJDD63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 23:58:29 -0400
Message-ID: <4160CA56.3040703@pobox.com>
Date: Sun, 03 Oct 2004 23:58:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange 2.6.9-rc3 keyboard repeat behavior
References: <415C8D7F.3020505@pobox.com> <20041001071323.GA5779@ucw.cz>
In-Reply-To: <20041001071323.GA5779@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Sep 30, 2004 at 06:49:35PM -0400, Jeff Garzik wrote:
> 
>>After booting into 2.6.9-rc3 release kernel, I am seeing strange and 
>>annoying keyboard repeat behavior.
>>
>>If I hold down a single key, while in X, the character will repeat at 
>>the expected (2.6.9-rc2 and prior) rate... for 1 second.
>>
>>After 1 second, the keyboard repeat rate slows to half or more.
>>
>>Can we please fix this?  Config attached.
> 
> 
> How does it behave on the console? The problem is that X generates its
> own software autorepeat and ignores what the kernel feeds it. So I
> suppose this might be more a gettimeofday or scheduling problem than one
> with the input layer.


Confirmed, console keyboard repeat does not show this behavior.

However...  this behavior does goes away when I boot an earlier kernel.

	Jeff


