Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266087AbUALJqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUALJqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:46:16 -0500
Received: from [212.239.224.205] ([212.239.224.205]:41346 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266087AbUALJqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:46:15 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Mon, 12 Jan 2004 10:45:56 +0100
User-Agent: KMail/1.5.4
Cc: Dax Kelson <dax@gurulabs.com>, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk>
In-Reply-To: <3FFFD61C.7070706@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121045.56749.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 11:38, Bart Samwel wrote:
> I've created a new version of the laptop-mode patch, this time against
> linux 2.6.1. It can be found here:
>
> http://www.liacs.nl/~bsamwel/laptop_mode/laptop-mode-2.6.1-7.patch
>
> It has no kernel code changes, only changes to the supporting
> documentation/scripts:
>
> * Dax Kelson's ACPI integration script is included.
> * Fixed a missing "esac" in the control script.
> * Minor documentation improvements.
>
> Especially Dax's addition should make it a lot more usable. I haven't
> been able to test this myself however, because I don't own a laptop. Dax
> probably does, so I'll trust him and assume that he has tested it. ;)

There seems to be a typo in the battery.sh script. It 
reads /proc/acpi/ac_adapter/AC/state to determine the AC Adaptor state, but 
this is in the ACAD directory instead of the AC directory.

Jan
-- 
The man on tops walks a lonely street; the "chain" of command is often a 
noose.

