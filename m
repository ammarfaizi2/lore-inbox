Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSKKGbv>; Mon, 11 Nov 2002 01:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265638AbSKKGbv>; Mon, 11 Nov 2002 01:31:51 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:42491 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265637AbSKKGbu>; Mon, 11 Nov 2002 01:31:50 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021110115408.GA22068@atrey.karlin.mff.cuni.cz> 
References: <20021110115408.GA22068@atrey.karlin.mff.cuni.cz>  <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com> <3205.1036707953@passion.cambridge.redhat.com> 
To: Pavel Machek <pavel@ucw.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Nov 2002 06:38:16 +0000
Message-ID: <7810.1036996696@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@ucw.cz said:
>  Yes... But how should "generic" battery info look like?
> On apm you only know percentages and ETA left.
> On acpi you know voltages, capacities and present rate.
> On zaurus you only know voltages.
> It will be quite hard to decide "one correct interface". It should
> probably be called "/proc/power".

Battery info call returns a structure where some elements can be 'unknown'. 
ACPI does it like that already, IIRC -- it's not mandatory to actually fill 
in every field correctly. 

--
dwmw2


