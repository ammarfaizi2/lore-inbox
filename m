Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284950AbRLKJnw>; Tue, 11 Dec 2001 04:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284951AbRLKJnm>; Tue, 11 Dec 2001 04:43:42 -0500
Received: from [195.66.192.167] ([195.66.192.167]:23569 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S284950AbRLKJne>; Tue, 11 Dec 2001 04:43:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bob Poortinga <bobp@savemail.com>, linux-kernel@vger.kernel.org
Subject: Re: Upgrade to 2.4.16 produces "Kernel panic: No init found"
Date: Tue, 11 Dec 2001 11:41:02 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3C150FD8.290BCBEC@savemail.com>
In-Reply-To: <3C150FD8.290BCBEC@savemail.com>
MIME-Version: 1.0
Message-Id: <01121111410200.01012@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 December 2001 17:41, Bob Poortinga wrote:
> Hello kernel gurus,
>
> I have searched the list archives and google'd myself silly, but I
> can't seem to find a solution to my problem.
>
> I am trying to update my 2.4.3 kernel (Mandrake 8.0 distro) to 2.4.16.
> I did a 'make oldconfig' with my old .config file and added ext3 kernel
> support in addition to ext2.  My root fs is ext2 (as are all my fs).
> The new kernel boots but panics when it tries to mount the root fs.
> Here is the error:
> --------------------------------------------------------------------
> Mounting /proc filesystem
> Creating root device
> Mounting root filesystem
> pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> Freeing unused kernel memory: 216k freed
> Kernel panic: No init found.  Try passing init= option to kernel.

Using initrd I guess?
Please describe your boot process.

Initrd support broke between 2.4.10 and 2.4.12, it does not like romfs and 
minix initrds anymore. I have a testcase.
--
vda
