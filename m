Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317265AbSFXDvn>; Sun, 23 Jun 2002 23:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317266AbSFXDvm>; Sun, 23 Jun 2002 23:51:42 -0400
Received: from rj.SGI.COM ([192.82.208.96]:30090 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317265AbSFXDvm>;
	Sun, 23 Jun 2002 23:51:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer_boundary isn't defined 
In-reply-to: Your message of "Sun, 23 Jun 2002 22:05:10 EST."
             <20020624030510.GA119@zion.mty.itesm.mx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Jun 2002 13:51:34 +1000
Message-ID: <4170.1024890694@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002 22:05:10 -0500, 
Felipe Contreras <al593181@mail.mty.itesm.mx> wrote:
>Doing some hacking I found something weird since 2.5.19, buffer_boundary and
>set_buffer_boundary are not defined, at least greping the source tree I couldn't
>find where they could be defined.
>
>The weird thing is that kbuild doesn't report that.

include/linux/buffer_head.h: BUFFER_FNS(Boundary, boundary).  Don't you
just love macros that generate names under the covers?


