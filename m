Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUJKOA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUJKOA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUJKOA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:00:56 -0400
Received: from dev.tequila.jp ([128.121.50.153]:262 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268966AbUJKOAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:00:53 -0400
Message-ID: <416A920E.6050709@tequila.co.jp>
Date: Mon, 11 Oct 2004 23:00:46 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 woes
References: <4169FCB5.8050808@tequila.co.jp> <1097465881.1418.4.camel@krustophenia.net>
In-Reply-To: <1097465881.1418.4.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/2004 12:38 PM, Lee Revell wrote:
> On Sun, 2004-10-10 at 23:23, Clemens Schwaighofer wrote:
> 
>>System: debian/unstable
>>
>>I just tried 2.6.9-rc3-mm3 and I have two problems:
>>
>>- - he calls himself 2.6.9-rc-mm31, yeah 31. I don't know where this comes
>>from, because in the Makefile itself it is mm3. Whatever makes him do
>>that, I don't know, but he install himselfs like this, perhaps the
>>problems come from that
>>
> 
> 
> Weird.  Works fine here.  Maybe this is a bug in the debian build
> process, try building from a fresh tree.

I'll build from kernel.org vanilla 2.8.1 + rc3 + mm3 patch.

>>- - cdrecord segfaults. Again I don't know if this is cdrecords fault or
>>not, but cdrecord works fine with 2.6.9-rc2-mm1
>>

> You might need to back out this patch:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch

oh thanks. I'll try that.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBapIOjBz/yQjBxz8RAjqyAJ9trl/eSGibfYIi6m0JggVK56IZCgCfWztG
yhT4j2QQy4c+p3Uk5c7ntD0=
=NBMG
-----END PGP SIGNATURE-----
