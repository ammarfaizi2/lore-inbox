Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTAYJYq>; Sat, 25 Jan 2003 04:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbTAYJYq>; Sat, 25 Jan 2003 04:24:46 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:33807 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266199AbTAYJYq>;
	Sat, 25 Jan 2003 04:24:46 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: modutils: using kallsyms when cross-compiling kernel 
In-reply-to: Your message of "Fri, 24 Jan 2003 22:06:58 MDT."
             <Pine.LNX.4.44.0301242200580.363-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Jan 2003 18:44:13 +1100
Message-ID: <16698.1043480653@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003 22:06:58 -0600 (CST), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On 24 Jan 2003, Roland Dreier wrote:
>
>> Is my diagnosis correct?  Is there any easy way for me to fix this (at
>> least enough so that I can build a PPC kernel on x86 with kkallsyms
>> support), or is the only solution to bite the bullet and fix the
>> modutils ELF code to be endianness clean?
>
>You could of course also backport the current 2.5 kallsyms code. This has,
>though originally based on kallsyms, been completely rewritten and not
>much to do with the original patch anymore (and different objectives).

The 2.5 kallsyms code is incomplete.  It is missing all the section
data which is required by kernel debuggers and profilers.
http://kerneltrap.org/node.php?id=500

