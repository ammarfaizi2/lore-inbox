Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313592AbSDHIug>; Mon, 8 Apr 2002 04:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313593AbSDHIuf>; Mon, 8 Apr 2002 04:50:35 -0400
Received: from rj.SGI.COM ([204.94.215.100]:13789 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313592AbSDHIue>;
	Mon, 8 Apr 2002 04:50:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Sun, 07 Apr 2002 16:18:12 +0200."
             <3CB05524.4643C805@linux-m68k.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 18:50:06 +1000
Message-ID: <1263.1018255806@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2002 16:18:12 +0200, 
Roman Zippel <zippel@linux-m68k.org> wrote:
>"touch include/linux/mm.h" doesn't cause a recompile of any object.

I have found a bug that is probably causing your problem.  Can you
confirm that you are using a common source and object directory, i.e.
no separate object tree?

