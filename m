Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTEFOMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTEFOMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:12:19 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:56392 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263765AbTEFOLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:11:33 -0400
Message-ID: <3EB7D399.4090109@myrealbox.com>
Date: Tue, 06 May 2003 08:24:09 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4a) Gecko/20030502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David van Hoose <davidvh@cox.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] Fails on "Uncompressing Kernel" (detailed)
References: <fa.athqjpk.133cvik@ifi.uio.no>
In-Reply-To: <fa.athqjpk.133cvik@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
> I've managed to get 2.5.69 to boot *once*. Not trusting the kernel to 
> report the numerous problems until I can boot the kernel more than once. 
> I lost my config so I can't figure out what I managed to do so right. I 
> have tried a couple other configs that I normally use for 2.4.x, but 
> with the new 2.5.x options. Those I have attached.
> All I get is the "Uncompressing Linux" and then no more output. However, 
> it appears that my system is booting anyway as if it is on another TTY. 

The configuration menu has changed recently so that support for normal
console operation is not included by default.  To activate the usual
console on VT and on VGA requires selecting options that are buried
in the 'Character device' 'Input device' and 'Graphics support' menu
sections.  Go all the way to the bottom of each section and you will
see the obvious items you need to select.  Rather a confusing change.

