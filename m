Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbQLUNfV>; Thu, 21 Dec 2000 08:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130996AbQLUNfM>; Thu, 21 Dec 2000 08:35:12 -0500
Received: from 213-123-73-18.btconnect.com ([213.123.73.18]:52229 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129901AbQLUNe4>;
	Thu, 21 Dec 2000 08:34:56 -0500
Date: Thu, 21 Dec 2000 13:06:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: sswapnee@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Mount system call hangs up the system
In-Reply-To: <CA2569BC.00442F0D.00@d73mta05.au.ibm.com>
Message-ID: <Pine.LNX.4.21.0012211304560.3864-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000 sswapnee@in.ibm.com wrote:
> Can somebody tell me why mount call just hangs?  Is there anyway to take a
> dump when the call is being executed.

You don't need a dump. Just go to the source and start inserting
printk() statements all over the sys_mount/do_mount etc. and sooner or
later the reason for hang will become obvious. Either it is a bug in your
program or in the kernel (or both). In any case it can be fixed.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
