Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSK1EiB>; Wed, 27 Nov 2002 23:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSK1EiB>; Wed, 27 Nov 2002 23:38:01 -0500
Received: from rj.SGI.COM ([192.82.208.96]:14013 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S265171AbSK1EiB>;
	Wed, 27 Nov 2002 23:38:01 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Wed, 27 Nov 2002 16:22:25 -0800."
             <200211280022.QAA07835@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Nov 2002 15:45:07 +1100
Message-ID: <23150.1038458707@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002 16:22:25 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	2.5.49 contains exports device ID tables again.  I think the
>existing depmod would work, except for some problem that Rusty found
>where it tries to use the kernel module interface (it really shouldn't
>care what operating system you're running as it should just read and
>write files).  Fix that depmod bug(?)

Not a bug.  depmod on its own reads the current kernel symbols.  depmod
-F map reads the symbosl from the mapfile and does not use the current
kernel at all.

