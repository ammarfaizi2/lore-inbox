Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbULNEfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbULNEfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbULNEfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:35:15 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:39949 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261406AbULNEeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:34:05 -0500
Message-ID: <41BE6C6B.6020103@lougher.demon.co.uk>
Date: Tue, 14 Dec 2004 04:30:35 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Announce] Squashfs 2.1 released (compressed filesystem)
References: <41BA0245.4050502@lougher.demon.co.uk> <20041212110112.GE17946@alpha.home.local>
In-Reply-To: <20041212110112.GE17946@alpha.home.local>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

> I've checked you tests, numbers are appealing :-)
> 
> BTW, you need to apply the following patch to build mksquashfs with gcc < 3.
> 
> Thanks for still improving this great FS !
> Willy

Hi

Thanks for your comments and thanks for the patch.  I also received 
reports that the kernel patches didn't build with gcc < 3.  This is 
because I used unamed structures and unions which are not supported by 
gcc < 3.  The "fun" of dealing with all the differing gcc versions in 
use out there :-)  I'll do another release with the code changes.

Phillip


