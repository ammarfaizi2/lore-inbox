Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUBVCim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUBVCim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:38:42 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:44210 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261646AbUBVCik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:38:40 -0500
Message-ID: <4038162C.7080301@cyberone.com.au>
Date: Sun, 22 Feb 2004 13:38:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <20040222021710.GD703@holomorphy.com>
In-Reply-To: <20040222021710.GD703@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>Similar issue here; I ran out of filp's/whatever shortly after booting.
>>>
>
>On Sat, Feb 21, 2004 at 06:03:14PM -0800, Mike Fedyk wrote:
>
>>So Nick Piggin's VM patches won't help with this?
>>
>
>I think they're in -mm, and I'd call the vfs slab cache shrinking stuff
>a vfs issue anyway because there's no actual VM content to it, apart
>from the code in question being driven by the VM.
>
>

Yes they're in -mm and in dire need of more testing.

The indented audience are people who's machines are swapping a lot,
but ensuring they don't break more common cases isn't a bad idea.

