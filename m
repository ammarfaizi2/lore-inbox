Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVCBPou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVCBPou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVCBPou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:44:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:4005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262319AbVCBPor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:44:47 -0500
Date: Wed, 2 Mar 2005 07:46:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
In-Reply-To: <20050302103158.GA13485@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
 <20050302103158.GA13485@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Matthias Andree wrote:
> 
> ftp.kernel.org:/pub/linux/kernel/v2.6 doesn't seem to carry a crypto
> signature for the patch, patch-2.6.11.gz.sign

It's there now (along with the ChangeLog).

The signatures are automatically generated at the master site, and the 
mirroring out to the public sites is a separate event, so sometimes (if 
you check early) you may miss the signatures for a while until the next 
time the scripts run.

The same is true of the .bz2 files, btw (I only upload the .gz ones, the 
rest is generated). And obviously the incremental patches.

(In contrast the full ChangeLog was missing because the generation script
I use is not exactly the smart way, so it's O(slow(n)), where slow is n**3 
or worse, so the log from the last -rc release is fast, but going back all 
the way to 2.6.10 took long long enough that I didn't wait for it).

		Linus
