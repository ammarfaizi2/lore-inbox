Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290276AbSAOUiA>; Tue, 15 Jan 2002 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAOUhu>; Tue, 15 Jan 2002 15:37:50 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:46062 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S290278AbSAOUhk>; Tue, 15 Jan 2002 15:37:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020115205332.B824@nightmaster.csn.tu-chemnitz.de> 
In-Reply-To: <20020115205332.B824@nightmaster.csn.tu-chemnitz.de>  <20020114165909.A20808@thyrsus.com> <8381.1011101338@redhat.com> 
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 20:37:06 +0000
Message-ID: <23620.1011127026@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ingo.oeser@informatik.tu-chemnitz.de said:
> 	make -C /lib/modules/`uname -r`/kernel SUBDIRS=`pwd` modules
> Which works quite pretty with 2.2.x Makefiles and Rules.make, but does
> not work with 2.4.x. I don't know if this is intentional or just
> oversight.

> If someone has a working makefile using this saner approach and even
> support subdirs I would apreciate it[1]. 

It works for me with 2.4, and I use it all the time. See the GNUmakefiles in
MTD CVS which do it automatically for you if you're not already running as
part of a kernel build.

--
dwmw2


