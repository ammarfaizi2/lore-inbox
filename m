Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbULUJME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbULUJME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbULUJME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:12:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:58073 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261424AbULUJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:12:00 -0500
To: Mark Nipper <nipsy@bitgnome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: timer is running twice as fast as it should (again??)
References: <87ekhkhf1j.fsf@londo.ultra.csn.tu-chemnitz.de>
	<20041220210909.GA49579@king.bitgnome.net>
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: Tue, 21 Dec 2004 10:10:24 +0100
In-Reply-To: <20041220210909.GA49579@king.bitgnome.net> (Mark Nipper's
 message of "Mon, 20 Dec 2004 15:09:09 -0600")
Message-ID: <87sm60auf3.fsf@londo.ultra.csn.tu-chemnitz.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:cf015127439e61eb16a460417aa16ac1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Nipper <nipsy@bitgnome.net> writes:

>> with 2.6 kernels, the timer on AMD64 runs exactly twice as fast as
>> expected. E.g. 'sleep 10' returns after 5 seconds external time.
>> 
>> This behavior was seen with Fedora Core 3 kernel 2.6.9-1.681_FC3 and
>> 2.6.10-rc3-bk13 (both x86_64 mode).
>> 
>> System information can be found at
>>                 http://www.tu-chemnitz.de/~ensc/hw/amd64
>
> 	Seem like something specific to Fedora or the bk branch
> then because I'm running 2.6.10-rc3 under x86_64 and it sleeps as
> long as it should.

Thanks for your testing but I can reproduce it both with vanilla 2.6.9
and 2.6.10-rc3. The used .config can be found at

          http://www.tu-chemnitz.de/~ensc/hw/amd64/config.txt




Enrico
