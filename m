Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVICTWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVICTWH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 15:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVICTWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 15:22:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:61154 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751210AbVICTWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 15:22:05 -0400
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.13: Filesystem capabilities 0.16
References: <87ll2ghb95.fsf@goat.bogus.local>
	<87fysnmvj6.fsf@amaterasu.srvr.nix>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 03 Sep 2005 21:21:55 +0200
Message-ID: <87k6hyez3g.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix <nix@esperi.org.uk> writes:

> On 1 Sep 2005, Olaf Dietsche murmured woefully:
>> This patch implements filesystem capabilities. It allows to run
>> privileged executables without the need for suid root.
>
> Is there some reason why this doesn't keep its capability data in
> xattrs?

When I started fscaps, xattr were new to me and I didn't understand
how to use them. So, I went and made a small and independent patch.

If you're interested in an xattr based approach, you may look at
<http://www.kernel.org/pub/linux/libs/security/linux-privs/>, which is
very old or at <http://www.stanford.edu/~luto/linux-fscap/>, which is
a more recent implementation.

As serge pointed out, there's a third from Nicholas Hans Simmonds.

Regards, Olaf.
