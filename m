Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTDHNok (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTDHNok (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:44:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34692 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261413AbTDHNoj (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:44:39 -0400
Date: Tue, 8 Apr 2003 09:58:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: prasanna panchamukhi <pprasanna_2000@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Magic numner of /dev/mem
In-Reply-To: <20030408133514.12649.qmail@web21404.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0304080952100.23087@chaos>
References: <20030408133514.12649.qmail@web21404.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, prasanna panchamukhi wrote:

> Hi,
>
> I have a few questions on /dev/mem
>
> 1.Is the magic no of /dev/mem is static or dynamic for
> a specific architecture.
> 2.If it is static/Dynamic why?
> 3. How it is determined?
> 3.Where do we use it?
>
> Thanks in advance...
>
> Regards
> Prasanna S P.

/dev/mem is not a "file" so it doesn't have a magic number. It
is a device that creates a "window" into all the mapped memory
pages in the system.

If you were to read /dev/mem (just do `strings /dev/mem` from
the root account), you will read the contents of physical memory.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

