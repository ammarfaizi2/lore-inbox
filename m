Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHANvq>; Thu, 1 Aug 2002 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSHANvp>; Thu, 1 Aug 2002 09:51:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44783 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313628AbSHANvp>; Thu, 1 Aug 2002 09:51:45 -0400
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Marcin Dalecki <dalecki@evision.ag>
In-Reply-To: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 16:12:06 +0100
Message-Id: <1028214726.14865.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 14:45, Ingo Molnar wrote:
> if i do it then the partition table gets corrupted and the system does not
> boot - it stops at 'LI'. (iirc meaning that the second-stage loader does
> not load?) Using a recovery CD fixes the problem, so it's only the
> partition info that got trashed, not the filesystem.
> 
> i use IDE disks.
> 
> this makes development under 2.5.29 quite inconvenient - i have to boot
> back into another kernel whenever loading a new kernel.

Does telling lilo to use "linear" mode help ? Some of the geometry stuff
in 2.5 seems a bit broken.

