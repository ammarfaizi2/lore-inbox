Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbUKQTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUKQTqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUKQTo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:44:26 -0500
Received: from mail.aknet.ru ([217.67.122.194]:50445 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262519AbUKQTnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:43:40 -0500
Message-ID: <419BAA0D.8010500@aknet.ru>
Date: Wed, 17 Nov 2004 22:44:13 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 (problem with cdrom)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Linus Torvalds wrote:
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10
I installed -rc2 and now the problem
with cd-rom I had in rc1-mm[45], is
also here.
The problem is that any process that is
trying to access the cdrom, gets stuck
in the kernel forever (actually, ~20
minutes after I typed "eject", the tray
was actually finally ejected, so it is not
really forever, but almost so). The
problem doesn't exist in -rc1.
All the relevant info about my cd-rom,
as well as the Alt-PrtSc-t traces are
in my previous report:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0411.1/2026.html
Any ideas what could cause this? If this
is not resolved, I guess under 2.6.10 I'll
not be able to use cd-rom, which would be
really very unfortunate for me :)
Is there any other info I can provide?

