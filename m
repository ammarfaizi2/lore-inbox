Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSG2TgJ>; Mon, 29 Jul 2002 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSG2TgJ>; Mon, 29 Jul 2002 15:36:09 -0400
Received: from www.transvirtual.com ([206.14.214.140]:65293 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317591AbSG2TgI>; Mon, 29 Jul 2002 15:36:08 -0400
Date: Mon, 29 Jul 2002 12:39:24 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: text screen corruption - bug in console vga code
In-Reply-To: <794826DE8867D411BAB8009027AE9EB91E7056D8@fmsmsx38.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0207291239040.13970-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have observed text mode console screen corruption on some architecture.
> The symptom was on a text console, when edit a large file with vi, pressing
> "down" arrow key to scroll would cause the corruption.
>
> It turns out that the culprit was the kernel console vga code where scrup()
> is illegally using mempcy() function when src/dest memory areas overlaps.
> This bug showed up when we optimized memcpy to use advanced optimization
> technique.
>
> This patch make use of memmove() which handles overlapping areas gracefully.
> Would the maintainer please push this into the base?

Done :-) Will be in th enext sync up.

