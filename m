Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUKISFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUKISFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUKISFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:05:20 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:2236 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261597AbUKISFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:05:12 -0500
Date: Tue, 09 Nov 2004 13:04:49 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: insmod module-loading errors, Linux-2.6.9
In-reply-to: <Pine.LNX.4.61.0411090745160.11563@chaos.analogic.com>
To: linux-os@analogic.com
Cc: Valdis.Kletnieks@vt.edu, Colin Leroy <colin.lkml@colino.net>,
       Linux kernel <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au
Message-id: <419106C1.40809@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
 <Pine.LNX.4.61.0411090745160.11563@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

linux-os wrote:
> On Mon, 8 Nov 2004 Valdis.Kletnieks@vt.edu wrote:
> 
>> On Mon, 08 Nov 2004 12:52:18 EST, linux-os said:
>>
>>> There are certainly work-arounds for problems that shouldn't
>>> exist at all. So, every time I do something to a kernel, I
>>> have to change whatever the EXTRAVERSION field is?  Then, when
>>> a customer demands that the kernel version be exactly the
>>> same that was shipped with Fedora or whatever, I'm screwed.
>>
>>
>> If you didn't have the foresight to keep that kernel version around,
>> there isn't much we can do to help you.  Yes, this may mean you have
>> a big bunch of /usr/src/linux-2.6.* directories.
>>
> 
> Wrong. Whoever put the module-loading code INSIDE the kernel,
> for POLITICAL reasons, created a new POLICY.
> 

No.  Version information is still stripped in module-init-tools in
_userspace_ for modprobe --force.  The fact that insmod doesn't support
'-f' is probably an oversight and Rusty would likely accept a patch.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkQbBdQs4kOxk3/MRArfFAJ9So6d7pRXqAgkuGj9XhsELsrymdgCfZs+x
Yz1bhTMbZkD35dbd8CEk+vk=
=kAgK
-----END PGP SIGNATURE-----
