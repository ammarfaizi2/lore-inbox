Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266588AbUGKNQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUGKNQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUGKNQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:16:26 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:56716 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266588AbUGKNQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:16:24 -0400
Message-ID: <40F13D96.10501@t-online.de>
Date: Sun, 11 Jul 2004 15:16:06 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>
In-Reply-To: <20040711084208.GA1322@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SyJhwvZe8eCTG8Rv4o8KJcrYu7f0z4sT9sB+XiWxCwk5xI+tP5xNrO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, Jul 11, 2004 at 09:00:22AM +0200, Harald Dunkel wrote:
> 
>>
>>Usually I wouldn't care, but I can go mad if the 4th mouse
>>button doesn't work :-).
>>
>>Any idea?
> 
>  
> Build the USB drivers into the kernel, or use the attached patch.
> If it helps, please tell me.
> 
> 

I tried the patch: Seems to work. After a power cycle the
mouse was detected as

Jul 11 15:09:29 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
Jul 11 15:09:29 r101 kernel: mice: PS/2 mouse device common for all mice

as expected.


Many thanx

Harri
