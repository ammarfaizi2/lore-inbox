Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271972AbTHRP3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272001AbTHRP3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:29:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17539 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271972AbTHRP3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:29:18 -0400
Date: Mon, 18 Aug 2003 11:31:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ramit Bhalla <ramit.bhalla@wipro.com>
cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Kernel Mode File Operations Wrappers
In-Reply-To: <52C85426D39B314381D76DDD480EEE0CF5FCAB@blr-m3-msg.wipro.com>
Message-ID: <Pine.LNX.4.53.0308181120190.15831@chaos>
References: <52C85426D39B314381D76DDD480EEE0CF5FCAB@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Ramit Bhalla wrote:

> Hi,
>
> I've written a file that provides wrappers for kernel mode file operations
> (using existing filp_xx and supporting operations).
> This provides support for opening/closing/reading/writing/seeking/formatting
> etc operations. This should help kernel mode developers with fs
> operations in their kernel drivers/modules.
>
> It helps simplify kernel mode file operations and takes care of
> various issues (which one can forget at times) like handling
> the FS  registers , uid and gid. It exposes kernel mode file
> operations in a way that are very similar to user mode
> operations like
> fopen, fclose, fseek etc.
>
> I have tested it on a few systems and it appears to be working great.
>
> Hope this finds it's way into the linux kernel :)
>
> Ramit.
>

This appears to be a cruel joke! From whom does the kernel steal
'current' when obtaining a file descriptor? And, how-come there
is a CR/LF sequence for each end-of-line? Is this some DOS program?

If there are any developers using file-access in their modules,
as stated above, that stuff should never be included in the kernel.
If those persons want to permanently damage the OS by doing same,
then they can do whatever in their own trees.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


