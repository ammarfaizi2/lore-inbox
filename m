Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUBJUsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUBJUsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:48:21 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58885 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265632AbUBJUsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:48:18 -0500
Message-ID: <40294472.3010203@tmr.com>
Date: Tue, 10 Feb 2004 15:52:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very preliminary dynamic pty patch
References: <1nK1K-78K-21@gated-at.bofh.it> <1nKEy-7RS-33@gated-at.bofh.it> <1nKY0-8jZ-31@gated-at.bofh.it>
In-Reply-To: <1nKY0-8jZ-31@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
>> On Tue, 10 Feb 2004 17:25:36 GMT, hpa@zytor.com (H. Peter Anvin)  said:
>>
>>> Try it out and send me the oopsen :)
>>>
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-1.patch
>>
>>
>> Eyeball checked only, 2 comments:
>>
>> 1) Will the embedded crew object to the removal of CONFIG_UNIX98_PTYS?
>> I can see some systems that don't want either SysV or BSD pty's, unless
>> they're deeply ingrained in some way I don't understand so you can't have
>> a system with exactly one tty on a DB-9 serial port for a console 
>> without having them present too.
>>
>> 2) How much extra code to axe the BSD-style PTYs?
> 
> 
> Actually it looks like it wouldn't be too much code either way.  I'll 
> probably make them both config options (with removal of the entire pty 
> subsystem if one chooses no on both.)

Thank you, this keeps everyone happy I would think.
