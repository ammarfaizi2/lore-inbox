Return-Path: <linux-kernel-owner+w=401wt.eu-S1751564AbWLXNq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWLXNq3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 08:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWLXNq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 08:46:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:18483 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbWLXNq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 08:46:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SPL0VfFkG24dLC+o1uZtKwDI0pJ6Ki5qSIJ5EVa6fLAHVVMXUhrCYqzK3okKgw33vdGfZg/P0aM00oJqzf/r4tocJBTz3Iehuiwep9YyjUk5Qx40jEyYiBqBzxw3bWiN/cKjjGYGCK2hUPn7mID9SIDkTLgVqqJ02NPVcJJX3Qw=
Message-ID: <458E84C6.7040100@gmail.com>
Date: Sun, 24 Dec 2006 14:46:23 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Alex Romosan <romosan@sycorax.lbl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.20-rc1: kernel BUG at fs/buffer.c:1235!
References: <87psaagl5y.fsf@sycorax.lbl.gov>
In-Reply-To: <87psaagl5y.fsf@sycorax.lbl.gov>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan wrote:
> this is on a thinkpad t40, not sure if it means anything, but here it goes:
> 
> kernel: kernel BUG at fs/buffer.c:1235!
> kernel: invalid opcode: 0000 [#1]
> kernel: PREEMPT 
> kernel: Modules linked in: radeon drm binfmt_misc nfs sd_mod scsi_mod nfsd exportfs lockd sunrpc autofs4 pcmcia firmware_class joydev irtty_sir sir_dev nsc_ircc irda crc_ccitt parport_pc parport ehci_hcd uhci_hcd usbcore aes_i586 airo nls_iso8859_1 ntfs yenta_socket rsrc_nonstatic pcmcia_core
> kernel: CPU:    0
> kernel: EIP:    0060:[<c016ad06>]    Not tainted VLI
> kernel: EFLAGS: 00010046   (2.6.20-rc1 #215)

Could you test 2.6.20-rc2? It's probably fixed there.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
