Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTBSUYu>; Wed, 19 Feb 2003 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbTBSUYu>; Wed, 19 Feb 2003 15:24:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:786 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267228AbTBSUYt>;
	Wed, 19 Feb 2003 15:24:49 -0500
Date: Wed, 19 Feb 2003 12:27:55 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, rmk@arm.linux.org.uk
Subject: Re: [BK PATCH] klibc for 2.5.62
Message-ID: <20030219202754.GA17593@kroah.com>
References: <20030219193907.GA17248@kroah.com> <20030219200935.GB1623@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219200935.GB1623@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 09:09:35PM +0100, Sam Ravnborg wrote:
> On Wed, Feb 19, 2003 at 11:39:07AM -0800, Greg KH wrote:
> >  usr/lib/arch/arm/MCONFIG                        |   26
> Any good reasons for such a screaming name?
> makefile.config eventually.

Ask Peter :)

> >  usr/lib/arch/arm/Makefile.inc                   |   31
> 
> No extension is used for arch/arm/Makefile
> Why does klibc differ in this respect?
> [An answer that tell me that arch/arm/Makefile should
> change is fine with me..]

Ask Russell :)

> >  usr/lib/makeerrlist.pl                          |   80 
> >  usr/lib/socketcalls.pl                          |   75 
> 
> This mixture of code and scripts to generate code hursts my eye.
> What about usr/scripts/.

But they are the scripts used to build the code in usr/lib.  I don't
care where they go, that's just where they were in the klibc tarball.

> I assume you do not want them in scripts/

Yeah, I wouldn't think they should go their either.

thanks,

greg k-h
