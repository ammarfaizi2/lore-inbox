Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424069AbWKIPqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424069AbWKIPqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424070AbWKIPqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:46:09 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:49816 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1424069AbWKIPqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:46:07 -0500
Message-ID: <45534D2C.6080509@gmail.com>
Date: Thu, 09 Nov 2006 16:45:48 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Jano <jasieczek@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com> <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com> <45534B31.50008@cfl.rr.com>
In-Reply-To: <45534B31.50008@cfl.rr.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip: please, so not top-post
Jano: please, do not remove Cc people, when replying (i.e. reply to all)

Phillip Susi wrote:
> Ubuntu uses an initramfs, so unless he has rebuilt his kernel to get
> around that, he should still be using one.

He has his own kernel with explicitly initrd disabled by config option (i.e. not
even supported by the kernel):
http://lkml.org/lkml/2006/11/09/11

> OP, please check dmesg for any new errors after you attempt to mount
> something on hdb.  Also what is the output of a mount command with no
> options?

There is a proc/mounts here:
http://lkml.org/lkml/2006/11/08/322

> Jiri Slaby wrote:
>> Aah, sorry for the question, you use 2.6.18.1 and there is no such
>> option yet.
>>
>> Despite you have ide-generic built-in and other drivers have as a
>> module and you don't use initrd. If I was you, I'll try to disable
>> ide-generic and choose your ide chipset as built-in in
>> ATA/ATAPI/MFM/RLL support under Device drivers.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
