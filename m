Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRDQMNo>; Tue, 17 Apr 2001 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132359AbRDQMNe>; Tue, 17 Apr 2001 08:13:34 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:32014 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129166AbRDQMNY>; Tue, 17 Apr 2001 08:13:24 -0400
Date: Tue, 17 Apr 2001 15:22:54 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer *WORKS* for a change!
In-Reply-To: <Pine.LNX.4.33.0104131932260.1502-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.30.0104171500050.20939-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Apr 2001, Mike A. Harris wrote:

> I just ran netscape which for some reason or another went totally
> whacky and gobbled RAM.  It has done this before and made the box
> totally unuseable in 2.2.17-2.2.19 befor the kernel killed 90% of
> my running apps before getting the right one.

I ported the 2.4 OOM killer about half year ago to 2.2, available for
2.2.19 kernel at
	http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_memory.html

Note, since it's activated in page fault handler that is architecture
dependent, the current patch works only on x86 (the only one I could
test). If one is interested in other archs, let me know.

   Szaka

