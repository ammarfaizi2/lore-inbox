Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275420AbRJATWc>; Mon, 1 Oct 2001 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275406AbRJATWW>; Mon, 1 Oct 2001 15:22:22 -0400
Received: from www.transvirtual.com ([206.14.214.140]:26380 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S275399AbRJATWO>; Mon, 1 Oct 2001 15:22:14 -0400
Date: Mon, 1 Oct 2001 12:22:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Rok Pergarec <rok@menuconfig.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual terminal support
In-Reply-To: <Pine.LNX.4.33.0110012033460.3086-100000@bla.menuconfig.org>
Message-ID: <Pine.LNX.4.10.10110011218590.28938-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is propably not so important but anyway. I think that the kernel
> should not complain about "unable to open an initial console" when
> "Virtual terminal" support is disabled in the kernel.

You do need stdin, stdout, and stderr which is related to /dev/console at
boot up. See main.c for what I mean. So you need some kind of console
built in. Try serial console and you need to tell your kernel you are
using serial console. See linux/Documentation/serialconsole.txt

