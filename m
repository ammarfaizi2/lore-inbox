Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbQLMMW0>; Wed, 13 Dec 2000 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbQLMMWP>; Wed, 13 Dec 2000 07:22:15 -0500
Received: from dhcp07.ncipher.com ([195.224.55.237]:22514 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S131161AbQLMMWE>; Wed, 13 Dec 2000 07:22:04 -0500
From: David Howells <dhowells@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling 
In-Reply-To: Your message of "08 Dec 2000 21:04:14 +0100."
             <m3zoi6pvh1.fsf@linux.local> 
Date: Wed, 13 Dec 2000 11:51:07 +0000
Message-ID: <21834.976708267@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm currently writing a Win32 emulation kernel module to help speed Wine up,
                                           ^^^^^^^^^^^^^
> fd = shm_open ("xxx",...)
> ptr = mmap (NULL, size, ..., fd, offset);

I am doing this from within kernel space. I'd like to avoid doing the full
open and mmap if possible. I was wondering if there're some shortcuts I could
make use of.

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
