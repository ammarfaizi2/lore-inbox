Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCSUtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUCSUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:48:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261168AbUCSUsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:48:04 -0500
Date: Fri, 19 Mar 2004 15:48:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CDFS
In-Reply-To: <1079727889.2735.1.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.53.0403191539220.5018@chaos>
References: <Pine.LNX.4.53.0403191100030.3154@chaos>
 <1079727889.2735.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Felipe Alfaro Solana wrote:

> On Fri, 2004-03-19 at 17:01, Richard B. Johnson wrote:
> > Just got a CD/ROM that 'works' on W$, but not Linux.
> > W$ `properties` call it 'CDFS'. Is there any such Linux
> > support?
>
> AFAICT, in Windows CDFS == ISO-9660, nothing more, nothing less.
> However, CDFS.SYS from Windows does have support for propietary Romeo
> and Jouliet extensions, which maybe are the culprit of the problem.
>

Well I just compiled in a module for UDF file-system since somebody
said it could be UDF on the CD instead of ISO-9660. In the process
of re-booting (nothing else), the CD decided to be mountable.

This doesn't make any sense because once the M$ CD wouldn't mount
I tried other ISO-9660 CDS and they mounted fine. I do backups
using ISO-9660 with the Joliet extensions as well. Anyway, I
could read the M$ CD using `od` as well.

So, all I did was re-boot (just like Windows) and it mounted fine.
Maybe there's somebody working on Linux that used to work for
M$, so it got infected with the Windows syndrome?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


