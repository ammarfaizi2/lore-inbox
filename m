Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTE0RmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTE0RlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:41:09 -0400
Received: from adsl-67-122-203-155.dsl.snfc21.pacbell.net ([67.122.203.155]:5817
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S264005AbTE0Rkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:40:31 -0400
Message-ID: <3ED3A60E.8040405@storadinc.com>
Date: Tue, 27 May 2003 10:53:18 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <3ED372DB.1030907@gmx.net> <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva> <200305271936.34006.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Tue, 27 May 2003, Marc-Christian Petersen wrote:
>
>>On Tuesday 27 May 2003 19:27, Marcelo Tosatti wrote:
>>
>>Hi Marcelo,
>>
>>>>Following is SysRq-T output for stuck processes during such a pause from
>>>>Christian Klose. Only processes in D state are listed for brevity.
>>>>Especially the last two call traces are interesting.
>>>>
>>>A "pause" is perfectly fine (to some extent, of course), now a hang is
>>>not. Is this backtrace from a hanged, unusable kernel or ?
>>>
>>A pause is _not_ perfectly fine, even not to some extent. That pause we are
>>discussing about is a pause of the _whole_ machine, not just disk i/o pauses.
>>Mouse stops, keyboard stops, everything stops, who knows wtf.
>>
>
>Do you also notice them?
>
>
>>That behaviour is absolutely bullshit for desktop users. For serverusage you
>>may not notice it in this dimension (mostly no X so no mouse), but also for a
>>server environment this may be very bad.
>>
>
>Agreed.
>
Hi Marc,

With respect to the hangs that you noticed, did the processes complete 
after a "pause" or did they stay hung (deadlocked)?

Thanks
Manish



