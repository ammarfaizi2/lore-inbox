Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289510AbSAJPqS>; Thu, 10 Jan 2002 10:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSAJPp6>; Thu, 10 Jan 2002 10:45:58 -0500
Received: from oker.escape.de ([194.120.234.254]:21782 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S289510AbSAJPpy>;
	Thu, 10 Jan 2002 10:45:54 -0500
Date: Thu, 10 Jan 2002 16:24:56 +0100 (CET)
From: Matthias Kilian <kili@outback.escape.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] klibc requirements
In-Reply-To: <a1grbm$n6o$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0201101619230.29097-100000@outback.escape.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002, H. Peter Anvin wrote:

> 		       initramfs buffer format
[...]
> compressed using gzip(1).  The simplest form of the initramfs buffer
> is thus a single .cpio.gz file.

FYI: I've already implemented this *simplest* form for .tar.gz files. A
patch can be found here:

http://www.escape.de/users/outback/linux/patch-2.4.17-inittar.gz

(I could also prepare a patch against 2.5.x)

So, before starting to implement the initramfs stuff, may be you should
have a look on my version.

Changing it from .tar to .cpio (if required) shouldn't be too difficult.

Bye,
	Kili

