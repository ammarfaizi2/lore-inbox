Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSGNASC>; Sat, 13 Jul 2002 20:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSGNASB>; Sat, 13 Jul 2002 20:18:01 -0400
Received: from codepoet.org ([166.70.99.138]:44769 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315468AbSGNASB>;
	Sat, 13 Jul 2002 20:18:01 -0400
Date: Sat, 13 Jul 2002 18:20:54 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Sandy Harris <pashley@storm.ca>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
Message-ID: <20020714002054.GB29007@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Sandy Harris <pashley@storm.ca>, Kirk Reiser <kirk@braille.uwo.ca>,
	linux-kernel@vger.kernel.org
References: <E17T15g-0007mP-00@speech.braille.uwo.ca> <3D2EF8DB.4DB091FF@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2EF8DB.4DB091FF@storm.ca>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 12, 2002 at 11:42:19AM -0400, Sandy Harris wrote:
> Does dietlibc help?
> 

This is kernel space.  Using any math functions is forbidden
in kernel space, so using dietlibc, uClibc, or anything else
is not going to work.  Moving the math stuff to userspace will
help, at which point he can use any C library that suits him,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
