Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUANAgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUANAgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:36:12 -0500
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:736
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S266215AbUANAgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:36:08 -0500
Message-ID: <40048EB4.9010500@winischhofer.net>
Date: Wed, 14 Jan 2004 01:35:00 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net> <20040113190443.GR9677@fs.tum.de>
In-Reply-To: <20040113190443.GR9677@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jan 10, 2004 at 05:04:53AM +0100, Thomas Winischhofer wrote:
> 
>>Adrian Bunk wrote:
>>
>>
>>>On Fri, Jan 09, 2004 at 01:40:03AM -0800, Andrew Morton wrote:
>>>
>>>
>>>>...
>>>>All 393 patches
>>>>...
>>>>use-soft-float.patch
>>>> Use -msoft-float
>>>>...
>>>
>>>
>>I know. The version of sisfb in 2.6 vanilla is from stone-age. This is 
>>has been fixed a long time ago in my current development version (and 
>>will be in 2.4 as soon as Marcelo applies my patch which I sent him 
>>about a week ago). For 2.6, using my current version requires James 
>>Simmons's fbdev-patch because of low-level fbdev-interface changes (like 
>>sysfs usage, etc).
>>
>>The whole framebuffer stuff in 2.6 is ancient. (Look at the file dates.)
> 
> 
> Until the framebuffer stuff in 2.6 gets updated, I'm suggesting the 
> patch below to mark FB_SIS as BROKEN.

I think that's a bit harsh. It basically works, it just illegally uses 
some FP operations (as it still does in 2.4 until Marcelo finally 
applies the patch I have sent him for three times now - hint, hint)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
