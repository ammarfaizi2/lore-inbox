Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVANVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVANVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVANVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:22:30 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:37628 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262123AbVANVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:22:11 -0500
Message-ID: <41E8565A.4050707@gentoo.org>
Date: Fri, 14 Jan 2005 23:31:38 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
References: <1105605448.7316.13.camel@localhost> <41E7F44C.5010702@bio.ifi.lmu.de>
In-Reply-To: <41E7F44C.5010702@bio.ifi.lmu.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:
> When I take an unpatched 2.6.10 and apply only the 033 patch, it fails,
> too. Is it possible that the rlimit patch needs some more patches from
> the bitkeeper repository to work correctly? And that those patches
> are missing in the -as1?  Or is the patch just wrong?
> 
> Can anyone confirm this problem? I attach my config for the full -as1
> tree kernel and a strace log for some segfaulting mount. Hope this helps!

I can confirm this. For me, fsck exits with sig11 during bootup sequence, 
which causes my init scripts to think my root partition is dead. Investigating 
now...

Daniel
