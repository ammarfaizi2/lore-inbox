Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWAFWn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWAFWn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWAFWn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:43:26 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:23791 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964873AbWAFWnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:43:25 -0500
Date: Fri, 6 Jan 2006 14:39:34 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
In-Reply-To: <20060106223702.GA3774@stusta.de>
Message-ID: <Pine.LNX.4.62.0601061438020.431@qynat.qvtvafvgr.pbz>
References: <20060106173547.GR12131@stusta.de>
 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
 <20060106180626.GV12131@stusta.de> <Pine.LNX.4.62.0601061305480.334@qynat.qvtvafvgr.pbz>
 <20060106223702.GA3774@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Adrian Bunk wrote:

> 
> On Fri, Jan 06, 2006 at 01:11:17PM -0800, David Lang wrote:
>> On Fri, 6 Jan 2006, Adrian Bunk wrote:
>> ...
>>>> - Being able to easily enable it in menuconfig, then browse through
>>>> the menus to look for something matching your hardware is nice, even
>>>> if that something is marked BROKEN at least you've then found a place
>>>> to start working on. A lot simpler than digging through directories.
>>>
>>> Our menus are mostly made for _users_.
>>
>> true, but do you really want to raise the barrier for users to test
>> things? or do you intend to have a bunch of patches that remove BROKEN for
>> a config option so that people can test them during the -rc and then add
>> it back for them all before a real release?
>
> If an option is untested it's EXPERIMENTAL.
> If it's broken it's BROKEN.
>
> If an option is marked as BROKEN but works fine for you please send a
> bug report.

my point is that if someone sends a patch that they think will fix 
something, nobody will be able to test that patch unless they are willing 
to edit their kconfig file unless the patch also marks it unbroken before 
anyone else has tested it.

David Lang
