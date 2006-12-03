Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760049AbWLCT7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049AbWLCT7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760050AbWLCT7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:59:33 -0500
Received: from mail.syneticon.net ([213.239.212.131]:12232 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1760049AbWLCT7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:59:32 -0500
Message-ID: <45732C8E.4060801@wpkg.org>
Date: Sun, 03 Dec 2006 20:59:10 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Ross Vandegrift <ross@kallisti.us>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us>
In-Reply-To: <20061203154936.GB26669@kallisti.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift wrote:
> On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
>> You mean the "Used by" column? No, it's not used by any other module 
>> according to lsmod output.
>>
>> Any other methods of checking what uses /dev/sda*?
> 
> There's a good chance that if it was loaded at system boot, hald or
> udev may be doing something with it.

This machine doesn't have hal; when I kill udevd still doesn't help.

Yes, something's using that drive, be it a program, a module (unlikely), 
or something that is compiled directly in the kernel (for example, 
md/raid1).
But what is it?

Kernel knows it, as it refuses to remove the module (via rmmod), but how 
to tell kernel to share this knowledge with me?


-- 
Tomasz Chmielewski
http://wpkg.org

