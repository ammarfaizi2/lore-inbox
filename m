Return-Path: <linux-kernel-owner+w=401wt.eu-S1752281AbWLXQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbWLXQ3w (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWLXQ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 11:29:51 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:1310 "EHLO sycorax.lbl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbWLXQ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 11:29:51 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.20-rc1: kernel BUG at fs/buffer.c:1235!
References: <87psaagl5y.fsf@sycorax.lbl.gov> <458E84C6.7040100@gmail.com>
Date: Sun, 24 Dec 2006 08:29:49 -0800
In-Reply-To: <458E84C6.7040100@gmail.com> (message from Jiri Slaby on Sun, 24
	Dec 2006 14:46:23 +0059)
Message-ID: <871wmpgsua.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> Alex Romosan wrote:
>> this is on a thinkpad t40, not sure if it means anything, but here it goes:
>> 
>> kernel: kernel BUG at fs/buffer.c:1235!
>> kernel: invalid opcode: 0000 [#1]
>> kernel: PREEMPT 
>> kernel: Modules linked in: radeon drm binfmt_misc nfs sd_mod scsi_mod nfsd exportfs lockd sunrpc autofs4 pcmcia firmware_class joydev irtty_sir sir_dev nsc_ircc irda crc_ccitt parport_pc parport ehci_hcd uhci_hcd usbcore aes_i586 airo nls_iso8859_1 ntfs yenta_socket rsrc_nonstatic pcmcia_core
>> kernel: CPU:    0
>> kernel: EIP:    0060:[<c016ad06>]    Not tainted VLI
>> kernel: EFLAGS: 00010046   (2.6.20-rc1 #215)
>
> Could you test 2.6.20-rc2? It's probably fixed there.

i switched to 2.6.20-rc2 last night. we'll see if it happens again.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
