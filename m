Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWAJQHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWAJQHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWAJQHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:07:42 -0500
Received: from gromit.trivadis.com ([193.73.126.130]:9518 "EHLO
	lttit.trivadis.com") by vger.kernel.org with ESMTP id S932094AbWAJQHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:07:41 -0500
Message-ID: <43C3DBBE.3090001@cubic.ch>
Date: Tue, 10 Jan 2006 17:07:26 +0100
From: Tim Tassonis <timtas@cubic.ch>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch> <20060110141324.GJ3911@stusta.de>
In-Reply-To: <20060110141324.GJ3911@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Jan 10, 2006 at 02:34:00PM +0100, Tim Tassonis wrote:
>> Like the OSS/Alsa or XFree3.x/XFree4.x situations.
> 
> And OSS/ALSA is an example why this is not a good thing:
> - OSS in the kernel is unmaintained

Because it is dead, yes...

> - people forced to use OSS drivers can't use applications only 
>   supporting ALSA

That is another problem. The problem is different API's. With networking 
drivers, that should really not be a problem once the device is up. You 
don't speak differently to different network devices, so applications 
will just do fine.

> But if you have the possibility to choose which stack to use at the 
> beginning (as in the wireless case), the only reasonable solution is to 
> choose _one_ stack.

... _if_ you have the possibility, yes. But you might end up having 
chosen the wrong one. There is a reason why two stacks exist.

Tim


