Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289617AbSAOTyU>; Tue, 15 Jan 2002 14:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289622AbSAOTyL>; Tue, 15 Jan 2002 14:54:11 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:48810 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S289617AbSAOTyC>; Tue, 15 Jan 2002 14:54:02 -0500
Date: Tue, 15 Jan 2002 20:53:32 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115205332.B824@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <8381.1011101338@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <8381.1011101338@redhat.com>; from dwmw2@infradead.org on Tue, Jan 15, 2002 at 01:28:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 01:28:58PM +0000, David Woodhouse wrote:
> Pity the people who wrote the driver didn't use the saner approach:
> 	make -C /lib/modules/`uname -r`/kernel SUBDIRS=`pwd` modules

Which works quite pretty with 2.2.x Makefiles and Rules.make, but
does not work with 2.4.x. I don't know if this is intentional or
just oversight.

If someone has a working makefile using this saner approach and
even support subdirs I would apreciate it[1].

Thanks & Regards

Ingo Oeser

[1] and spend him a sixpack when I meet him next time ;-)
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
     >>>   4. Chemnitzer Linux-Tag - 09.+10. Maerz 2002 <<<
              http://www.tu-chemnitz.de/linux/tag/
