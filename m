Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSFKMSe>; Tue, 11 Jun 2002 08:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSFKMSd>; Tue, 11 Jun 2002 08:18:33 -0400
Received: from ns.suse.de ([213.95.15.193]:12805 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317020AbSFKMSd>;
	Tue, 11 Jun 2002 08:18:33 -0400
Date: Tue, 11 Jun 2002 14:18:33 +0200
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 no source for several objects
Message-ID: <20020611141832.K13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <8028.1023759039@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:30:39AM +1000, Keith Owens wrote:
 > These objects are referenced in makefiles but no source exists.
 > 
 > arch/i386/kernel/Makefile
 > obj-$(CONFIG_EISA)              += eisa.o

My bad. Can be deleted.

 > None of these were picked up by the existing build system, they were
 > all detected by kbuild 2.5.

It should bite as soon as someone tries to compile a kernel with EISA
support. If it doesn't, that really needs fixing.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
