Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWCUMjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWCUMjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWCUMjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:39:43 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:55647 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751591AbWCUMjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:39:43 -0500
Message-ID: <441FF40A.1050501@tls.msk.ru>
Date: Tue, 21 Mar 2006 15:39:38 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Merge strategy for klibc
References: <441F0859.2010703@zytor.com>
In-Reply-To: <441F0859.2010703@zytor.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Okay, as of this point, I think klibc is in quite good shape; my
> testing so far is showing that it can be used as a drop-in replacement
> for the kernel root-mounting code.
[]
> Thus, it's not clear to me what particular approach makes most sense for
> pushing upstream.

Why this needs to be "pushed" upstream in the first place?  Isn't it
simpler/easier/whatever to just require klibc to be present on the
build system for kernel?  If klibc is "sufficiently" independent of
the kernel (is it?  I see no reason it shouldn't), why it should go
with kernel?  Just point your CONFIG_INITRAMFS_SOURCE to some klibc
directory tree and be done with it, no need to distribute/build
klibc with kernel..

Thanks.

/mjt
