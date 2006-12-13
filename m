Return-Path: <linux-kernel-owner+w=401wt.eu-S932617AbWLMIey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWLMIey (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWLMIex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:34:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54488 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbWLMIex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:34:53 -0500
X-Greylist: delayed 1944 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 03:34:53 EST
Subject: Re: Support 2.4 modules features in 2.6
From: Arjan van de Ven <arjan@infradead.org>
To: Jaswinder Singh <jaswinderrajput@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aa5953d60612120848y47ad5365x5e5acf9d1839a7d@mail.gmail.com>
References: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
	 <1165932674.27217.608.camel@laptopd505.fenrus.org>
	 <aa5953d60612120711h375eecadpeb20d971853626cc@mail.gmail.com>
	 <1165937853.27217.625.camel@laptopd505.fenrus.org>
	 <aa5953d60612120848y47ad5365x5e5acf9d1839a7d@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Dec 2006 09:06:37 +0100
Message-Id: <1165997197.27217.728.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Really!! , Please let me know what is the procedure to build the
> > > modules after deleting kernel linux-2.6*
> >
> > you only need include/* for this in 2.6
> >
> > you can't do this at all with 2.4 kernels, it needs the whole lot.
> >
> > (in both cases the code and headers are needed so that your module can
> > use the data structures and compile in the kernel code you select to use
> > from inlines)
> > >
> > >
> 
> Really!!
> 
> This is my Makefile :-
> obj-m += hello-1.o
> 
> all:
> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> 
> clean:
> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
> 
> 
> Now do one thing:-
> # mv /lib/modules/$(uname -r)/build /lib/modules/$(uname -r)/build0
> 
> now make it.
> 
> If you want point to your header files in /usr/include and then try to build.

so you first copy a big chunk of your 2.4 source tree, delete the
original and then say "look it can compile without". Please be real and
honest :)

anyway I suggest that you answer the question on where the code is so
that we can help you....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

