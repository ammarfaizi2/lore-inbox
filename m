Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbTCZUAU>; Wed, 26 Mar 2003 15:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbTCZT7j>; Wed, 26 Mar 2003 14:59:39 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:44550 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261999AbTCZT7f>; Wed, 26 Mar 2003 14:59:35 -0500
Date: Wed, 26 Mar 2003 20:10:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org, bert hubert <ahu@ds9a.nl>
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
In-Reply-To: <20030326145412.GI2078@wiggy.net>
Message-ID: <Pine.LNX.4.44.0303262009560.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Previously bert hubert wrote:
> > On Debian, ls /dev/fb[67] results in:
> > crw--w--w-    1 root     tty       29, 192 Nov 30  2000 /dev/fb6
> > crw--w--w-    1 root     tty       29, 224 Nov 30  2000 /dev/fb7
> 
> Documentation/devices.txt (at least in 2.5.64) states that those
> devices should be fully supported:
> 
>                 For backwards compatibility {2.6} the following
>                 progression is also handled by current kernels:
>                   0 = /dev/fb0
>                  32 = /dev/fb1
>                     ...
>                 224 = /dev/fb7

That is no longer true. The fb nodes should be recreated. I fixed the docs 
in devices.txt



