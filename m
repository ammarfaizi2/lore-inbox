Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQL0LS3>; Wed, 27 Dec 2000 06:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQL0LST>; Wed, 27 Dec 2000 06:18:19 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:37898 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129415AbQL0LSM>; Wed, 27 Dec 2000 06:18:12 -0500
Date: 27 Dec 2000 11:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: esr@snark.thyrsus.com
cc: linux-kernel@vger.kernel.org
cc: linux-kbuild@torque.net
cc: torvalds@transmeta.com
Message-ID: <7sfRARgmw-B@khms.westfalen.de>
In-Reply-To: <200012262313.eBQNDBi07719@snark.thyrsus.com>
Subject: Re: How do we handle autoconfiguration?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200012262313.eBQNDBi07719@snark.thyrsus.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC: list drastically trimmed]

esr@snark.thyrsus.com (Eric S. Raymond)  wrote on 26.12.00 in <200012262313.eBQNDBi07719@snark.thyrsus.com>:

> Linus, replying to Alan:
> >> If we do that I'd rather see a make autoconfig that does the lot from
> >> proc/pci etc 8)
> >
> >Good point. No point in adding a new config option, we should just have a
> >new configurator instead. Of course, it can't handle many of the
> >questions, so it would still have to fall back on asking.

> My original design for CML2 included a way to capture the results from
> arbitrary procedural probes written in C or some scripting language
> and use them in predicates.  Imagine something like this:
>
> # PROCESSOR is string valued; we capture stdout from the probe
> derive PROCESSOR from "myprobe1.sh"

I hope that design wouldn't mean that you can't configure a kernel on a  
machine different from the one supposed to run it, nor that you can't  
gather the autoconfiguration info on a machine where you won't build the  
kernel and don't have the full kernel sources.

Because that's a rather common situation in nontrivial installations.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
