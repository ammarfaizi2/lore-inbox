Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVCUX7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVCUX7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVCUXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:55:21 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:48085 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262144AbVCUXen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:34:43 -0500
Message-ID: <423F5A0A.7060307@ens-lyon.org>
Date: Tue, 22 Mar 2005 00:34:34 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       keenanpepper@gmail.com
Subject: Re: i830 DRM problems
References: <422C5A25.3000701@ens-lyon.org>	<21d7e99705031115075e4378ed@mail.gmail.com> <20050321151453.695c73e2.akpm@osdl.org>
In-Reply-To: <20050321151453.695c73e2.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Dave Airlie <airlied@gmail.com> wrote:
> 
>>>I am experiencing problems with DRM on my Dell Optiplex GX260.
>>>I am running a Debian Sarge with Vanilla Linux 2.6.11 and XFree 4.3.0.
>>>This one appeared while playing crack-attack and lead to a crash
>>>of the X server.
>>>
>>
>>a) does it work with 2.6.10?
>>b) does it work if you turn off intelfb?
>>
> 
> afacit we're still waiting for an answer from Brice on this one?

Sorry about that, we start to talk about it in private with Dave.
But, I did not really it since Keenan Pepper told me it was due
to a bug in the XFree 4.3 driver.
I am now using Xorg and didn't see any DRM problem since.
However, I can't confirm that my bug was surely due to the XFree driver 
and not to the kernel driver since Xorg uses i915 instead of i830.
Keenan, do you have details ?

I was also talking about a problem in intelfb on this box (i845G).
Basically, it works great during startup. But from what I remember, it
always crashes when switching from X to a text console.
I'll try to debug this one soon.

Brice
