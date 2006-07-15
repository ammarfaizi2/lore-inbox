Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWGOGia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWGOGia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 02:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWGOGia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 02:38:30 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:60041 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422804AbWGOGia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 02:38:30 -0400
Date: Sat, 15 Jul 2006 08:38:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tighten ATA kconfig dependancies
Message-ID: <20060715063827.GA24579@mars.ravnborg.org>
References: <20060715053418.GA5557@redhat.com> <1152942548.3114.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152942548.3114.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 07:49:08AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> > A lot of prehistoric junk shows up on x86-64 configs.
> 
> 
> ... but in general it helps compile testing if you're hacking stuff;
> if your hacking IDE on x86-64 you now have to compile 32 bit as well to
> see if you didn't break the compile for these as well
> 
> So please don't do this, just disable them in your config...

An i686 cross compile chain seems to be the natural choice here?

	Sam
