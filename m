Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269463AbUHZTow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269463AbUHZTow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269502AbUHZToo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:44:44 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50324 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S269472AbUHZTki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:40:38 -0400
Date: Thu, 26 Aug 2004 21:41:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, kai@germaschewski.name,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compile error if make O=/some/other/dir in 2.6.9-rc1
Message-ID: <20040826194136.GH9539@mars.ravnborg.org>
Mail-Followup-To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>,
	Sam Ravnborg <sam@ravnborg.org>, kai@germaschewski.name,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1093464584.23633.31.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093464584.23633.31.camel@duffman>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:09:44PM -0700, Thomas Duffy wrote:
> This was introduced in 2.6.9-rc1
> 
> $ make V=1 O=/tmp/kbuild2/
> 
>   gcc -Wp,-MD,arch/x86_64/boot/tools/.build.d -Iarch/x86_64/boot -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o arch/x86_64/boot/tools/build /build1/tduffy/openib-work/linux-2.6.9-rc1-openib/arch/x86_64/boot/tools/build.c
> cc1: No such file or directory: opening dependency file arch/x86_64/boot/tools/.build.d
> make[2]: *** [arch/x86_64/boot/tools/build] Error 1
> make[1]: *** [bzImage] Error 2
> make: *** [_all] Error 2

Thanks.

Fixet, see separate mails sent to lkml with title "kbuild fixes".

	Sam
