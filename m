Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTJNRvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTJNRvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:51:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30080 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262363AbTJNRvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:51:17 -0400
Date: Tue, 14 Oct 2003 13:51:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Maciej Zenczykowski <maze@cela.pl>, jlnance@unity.ncsu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
In-Reply-To: <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0310141350280.1540@chaos>
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
 <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, John Bradford wrote:

> > On one hand I agree with you - OTOH: why not run an older version of the
> > kernel?
>
> Security issues.  That applies for userspace as well.  Not upgrading,
> or at least disabling the functionality with the security issue is
> irresponsible.
[SNIPPED...]


>
> > As for making the kernel smaller - perhaps a solution would be to code all
> > strings as error codes and return ERROR#42345 or something instead of the
> > full messages - there seem to be quite a lot of them.  I don't mean to
> > suggest this solution for all compilations but perhaps a switch to remove
> > strings and replace them with ints and then a seperately generated file of
> > errnum->string. I'd expect that between 10-15% of the uncompressed kernel
> > is currently pure text.
>
> I agree, error codes would be nice, but this discussion has come up
> before and I doubt they will ever get in to mainline.
>

Really good guess!

-rw-r--r--   1 root     root       151483 Oct 14 13:49 Strings.txt
-rwxr-xr-x   1 root     root      1567340 Oct 14 09:39 vmlinux

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


