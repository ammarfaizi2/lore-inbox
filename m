Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277117AbRJLAHI>; Thu, 11 Oct 2001 20:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277115AbRJLAG6>; Thu, 11 Oct 2001 20:06:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42113 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277111AbRJLAGx>;
	Thu, 11 Oct 2001 20:06:53 -0400
Date: Thu, 11 Oct 2001 17:07:19 -0700 (PDT)
Message-Id: <20011011.170719.48535224.davem@redhat.com>
To: lsawyer@gci.com
Cc: linux-kernel@vger.kernel.org, jhartmann@valinux.com, gareth.hughes@acm.org
Subject: Re: [BUG] Linux-2.4.12 does not build (Sparc-64 & DRM)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506146916@berkeley.gci.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506146916@berkeley.gci.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Leif Sawyer <lsawyer@gci.com>
   Date: Thu, 11 Oct 2001 15:52:01 -0800

   Just a quick bug report -- I haven't had time
   to track this one down yet.
   
   Enabling DRM/DRI support on a Sparc64 kernel
   with Creator/Creator3D graphics does not build
   correctly:
   
I've tried to contact the DRM folks (specifically Jeff Hartman) on
many occaisions (at least 3 times) about the fact that using
virt_to_bus/bus_to_virt generically in the DRM broke the build on
several platforms.

As stated often, virt_to_bus/bus_to_virt are deprecated interfaces.
Yet, it is use explicitly in the debugging macros.

Not only has it not been fixed, all of my queries to Jeff have fallen
on deaf ears and I get no response whatsoever.

Franks a lot,
David S. Miller
davem@redhat.com
