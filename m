Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbRLDTHl>; Tue, 4 Dec 2001 14:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283293AbRLDTGS>; Tue, 4 Dec 2001 14:06:18 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:49874 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283356AbRLDTFb>; Tue, 4 Dec 2001 14:05:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stefani Seibold <stefani@seibold.net>
To: "Tommy Faasen" <faasen@xs4all.nl>
Subject: Re: patch for suppress printk messages
Date: Tue, 4 Dec 2001 20:03:40 +0100
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <16BIdM-12MonAC@fmrl05.sul.t-online.com> <001e01c17cea$d6b03c30$6400a8c0@it0>
In-Reply-To: <001e01c17cea$d6b03c30$6400a8c0@it0>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16BKsI-1gn0XAC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel will not do any printk debug output. The kernel
will boot silently. Only the output of userland processes will
make outputs to the console.
This patch is not for big systems like desktop or server. It is 
designed for systems with a very small footprint, like a toaster 
or a dvd player.
On this kind of systems the hardware normaly never change 
and there is not very much memory.

Am Dienstag, 4. Dezember 2001 18:40 schrieb Tommy Faasen:
> Can you show an example what is printed now?
>
> Thanks
> ----- Original Message -----
> From: "Stefani Seibold" <stefani@seibold.net>
> To: <torvalds@transmeta.com>; <alan@lxorguk.ukuu.org.uk>
> Cc: <linux-kernel@vger.kernel.org>; <Stefani@seibold.net>
> Sent: Tuesday, December 04, 2001 5:40 PM
> Subject: patch for suppress printk messages
>
