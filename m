Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVA0S40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVA0S40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVA0S40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:56:26 -0500
Received: from alog0423.analogic.com ([208.224.222.199]:46976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262706AbVA0SzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:55:12 -0500
Date: Thu, 27 Jan 2005 13:54:30 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Viktor Horvath <ViktorHorvath@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: patches to 2.6.9 and 2.6.10 - make menuconfig shows "v2.6.8.1"
In-Reply-To: <1106851254.720.4.camel@Charon>
Message-ID: <Pine.LNX.4.61.0501271350440.23139@chaos.analogic.com>
References: <1106851254.720.4.camel@Charon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Viktor Horvath wrote:

> Hello everybody,
>
> today I patched myself up from 2.6.7 vanilla to 2.6.10 vanilla, but
> after all patches succeeded, "make menuconfig" shows "v2.6.8.1
> Configuration". Even worse, a compiled kernel calls in his bootlog
> himself "2.6.8.1". When installing the whole kernel package, this
> behaviour doesn't show up.
>
> Sorry if this is a dumb question, but I could not find an answer in the
> archives.
>
> Have a nice day,
> Viktor.

Check the Makefile, near the beginning:

# head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 10
EXTRAVERSION =
NAME=Woozy Numbat

Put in the numbers you expect.
Do `make clean ; make` all over again.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
