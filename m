Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSJHKDd>; Tue, 8 Oct 2002 06:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261739AbSJHKDd>; Tue, 8 Oct 2002 06:03:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:18440 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261732AbSJHKDc>;
	Tue, 8 Oct 2002 06:03:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: vpath broken in 2.5.41 
In-reply-to: Your message of "Mon, 07 Oct 2002 20:39:46 EST."
             <Pine.LNX.4.44.0210072037520.32256-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 20:09:03 +1000
Message-ID: <29031.1034071743@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002 20:39:46 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Tue, 8 Oct 2002, John Levon wrote:
>> I see vpath seems to have become broken in 2.5.41 build.
>> How now can I build the oprofile.o target from two directories ?
>
>I see in the patch you mailed later that you got it figured out already, 
>using a relative path.
>And yeah, it's not particularly beautiful. But I do not see any nice and 
>easy way, either.

This is one of the problems that kbuild 2.5 was designed to handle, to
cope with modules built from code in multiple directories.  I support
what the developer wants to do, not restrict the developer to what the
kernel build can handle.

Pity that Linus thinks that there are no kbuild problems that require
kbuild 2.5 ...

