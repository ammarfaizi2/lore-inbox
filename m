Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTAWSNh>; Thu, 23 Jan 2003 13:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbTAWSNh>; Thu, 23 Jan 2003 13:13:37 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34054 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265567AbTAWSNf>;
	Thu, 23 Jan 2003 13:13:35 -0500
Date: Thu, 23 Jan 2003 19:22:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030123182236.GA14184@mars.ravnborg.org>
Mail-Followup-To: Thomas Schlichter <schlicht@uni-mannheim.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030123165256.GA1092@mars.ravnborg.org> <200301231832.59942.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301231832.59942.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 06:32:59PM +0100, Thomas Schlichter wrote:
> Thanks for your answers!
> 
> I did not compile my module with a kernel Makefile, I used the very small and 
> simple one attatched to this mail. So it seems I miss something when the 
> module is linked and I have to know what I have to link to the module or 
> which header-file I have to include...
> 
> For me it seems link I have to link the init/vermagic.c file to my module, but 
> how would this be possible if only the kernel includes were available??
> I think only these should be needed to compile a module...

As it is today the only sane way is to have the full kernel src available.
It should be possible to minimize that - but I do not feel tempted to
do so.

We want to do too much to rely on whatever makefile people write for
their module.

	Sam
