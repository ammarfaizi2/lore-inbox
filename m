Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287866AbSBCXf3>; Sun, 3 Feb 2002 18:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSBCXfT>; Sun, 3 Feb 2002 18:35:19 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36114 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287866AbSBCXfB>;
	Sun, 3 Feb 2002 18:35:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Fri, 01 Feb 2002 14:42:11 BST."
             <200202011342.g11DgBfd001291@tigger.cs.uni-dortmund.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Feb 2002 10:34:48 +1100
Message-ID: <15269.1012779288@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2002 14:42:11 +0100, 
Horst von Brand <brand@jupiter.cs.uni-dortmund.de> wrote:
>Keith Owens <kaos@ocs.com.au> said:
>> I know, it makes it even harder to see what the initialization order
>> is.  Some are controlled by the Makefile/subdirs order, some by special
>> calls in the code.
>
>Just to repeat myself: This is clearly a problem for tsort(1): Give
>restrictions of the form "This has to come after that" (perhaps a special
>comment at the start of the file containing the init function?), tsort that
>and pick the order out of the result. Should be a few lines of script. No
>central repository for the dependencies, no messing around with half the
>world to fix dependencies. Plus they become explicit, which they aren't
>today.

Just to repeat myself: That is exactly what I want to do.  Linus vetoed
it in October 2000.

