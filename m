Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVAEUKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVAEUKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVAEUKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:10:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:39127 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262596AbVAEUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:09:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ast@domdv.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, joq@io.com
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org>
	<1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	<1104898693.24187.162.camel@localhost.localdomain>
	<20050104215010.7f32590e.akpm@osdl.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 05 Jan 2005 21:09:18 +0100
Message-ID: <87ekgzwscx.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>  Can we use capabilities
>
> capabilities don't work :(
>
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0502.html

Capabilities don't work, because of missing filesystem
capabilities. If you have them, it's a question of setting the
appropriate permitted, inheritable and effective capability sets.

I didn't follow the whole thread. But if you want to grant
capabilities on a per user/group basis, may I suggest accessfs user
based capabilities, for example? :-)

Regards, Olaf.
