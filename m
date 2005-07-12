Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVGLMWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVGLMWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGLMUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:20:07 -0400
Received: from alog0200.analogic.com ([208.224.220.215]:7090 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261371AbVGLMTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:19:33 -0400
Date: Tue, 12 Jul 2005 08:17:02 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Patrick McHardy <kaber@trash.net>
cc: Denis Vlasenko <vda@ilport.com.ua>, sander@humilis.net,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
In-Reply-To: <42D3AFA1.2090203@trash.net>
Message-ID: <Pine.LNX.4.61.0507120809200.2712@chaos.analogic.com>
References: <20050711145616.GA22936@mellanox.co.il> <20050711153447.GA19848@favonius>
 <200507120952.04279.vda@ilport.com.ua> <42D3AFA1.2090203@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Patrick McHardy wrote:

> Denis Vlasenko wrote:
>> text with 8-char tabs:
>>
>> struct s {
>>         int n;          /* comment */
>>         unsigned int u; /* comment */
>> };
>>
>> Same text viewed with tabs set to 4-char width:
>>
>> struct s {
>>     int n;      /* comment */
>>     unsigned int u; /* comment */
>> };
>>
>> Comments are not aligned anymore
>
> Best rule IMO is to use tabs for indentation and spaces for alignment.
> This way tab size can be changed without breaking alignment.

Or just disallow tabs altogether. At Analogic we had several hundred
thousand lines of imaging code from various engineers around the world.
They would set their tabs so everything looked fine on their computers.
On other computers, it looked like hell so engineers who had to
merge code spent hundreds of wasted hours lining up the code. The
"cleanup" work never stopped! That was until, we made a rule that
all code would be run through a filter that would remove tabs and
substitute spaces (of the width the writer intended). No code that
is released contains even a single tab anymode.

The files are larger of course, but even lap-tops have gigabyte
drives now-days and the duplicate spaces give compression utilities
something to do.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
