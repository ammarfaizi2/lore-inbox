Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbRBVE0m>; Wed, 21 Feb 2001 23:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130178AbRBVE0c>; Wed, 21 Feb 2001 23:26:32 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:25928 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129602AbRBVE0O>;
	Wed, 21 Feb 2001 23:26:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Billy Harvey <Billy.Harvey@thrillseeker.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2 
In-Reply-To: Your message of "Wed, 21 Feb 2001 22:19:20 CDT."
             <14996.34104.791600.203558@rhino.thrillseeker.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Feb 2001 15:25:46 +1100
Message-ID: <936.982815946@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001 22:19:20 -0500, 
Billy Harvey <Billy.Harvey@thrillseeker.net> wrote:
>ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
>ld: cannot open binary: No such file or directory

Change -oformat to --oformat.  Binutils incompatibility.

