Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275740AbRI0C2A>; Wed, 26 Sep 2001 22:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275739AbRI0C1t>; Wed, 26 Sep 2001 22:27:49 -0400
Received: from rj.sgi.com ([204.94.215.100]:32204 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275742AbRI0C1f>;
	Wed, 26 Sep 2001 22:27:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kiril Vidimce <vkire@pixar.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max arguments for exec 
In-Reply-To: Your message of "Wed, 26 Sep 2001 14:25:05 MST."
             <Pine.LNX.4.21.0109261417110.24013-100000@nevena> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Sep 2001 12:27:52 +1000
Message-ID: <8237.1001557672@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 14:25:05 -0700 (PDT), 
Kiril Vidimce <vkire@pixar.com> wrote:
>Is there any way to reconfigure the kernel at runtime to change the
>limit for arguments passed during an exec? I guess I am looking for
>something similar to systune ncargs under IRIX. I found this thread
>in the archives:
>
>http://uwsg.iu.edu/hypermail/linux/kernel/0003.0/0160.html
>
>The only suggestion was to patch and recompile the kernel. I looked
>into sysctl and I couldn't find an appropriate argument to tweak.

It is controlled by MAX_ARG_PAGES in include/linux/binfmts.h.  Change
and recompile the kernel, it is not dynamically tunable in Linux.

