Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVG1Iq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVG1Iq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG1Iq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:46:29 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:8085 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261366AbVG1Iq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:46:27 -0400
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>
	<buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<42E896EC.7030503@ppp0.net>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 28 Jul 2005 17:46:18 +0900
In-Reply-To: <42E896EC.7030503@ppp0.net> (Jan Dittmer's message of "Thu, 28 Jul 2005 10:27:24 +0200")
Message-Id: <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <jdittmer@ppp0.net> writes:
>> "v850e-elf".
>
> Thanks, that got me much further, compilation aborts now with

Hmmm, what sources are you compiling exactly?

I last tested with 2.6.12 + 2.6.12-uc0 (uClinux) patches + the v850 patches
I sent to the LKML recently (from which I presume you got the defconfigs);
the v850 patches should now be merged into Linus's tree, but I dunno about
the uClinux patches (and of course there may already be v850 breakage in
Linus's current tree; I usually only test real releases).

If you care to try applying the uClinux patches, they should be available
from (fill in "$ver" with "2.6.12-uc0" and "$maj_ver" with "2.6"):

    http://www.uclinux.org/pub/uClinux/uClinux-$maj_ver.x/linux-$ver.patch.gz

Greg, do you have any status on merging the current uClinux patch set?

Thanks,

-Miles
-- 
Everywhere is walking distance if you have the time.  -- Steven Wright
