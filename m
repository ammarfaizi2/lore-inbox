Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSLJSNo>; Tue, 10 Dec 2002 13:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSLJSNn>; Tue, 10 Dec 2002 13:13:43 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:32472 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264790AbSLJSNn>; Tue, 10 Dec 2002 13:13:43 -0500
Date: Tue, 10 Dec 2002 18:21:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Antonino Daplas <adaplas@pol.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210182120.GD577@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Antonino Daplas <adaplas@pol.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain> <20021210140301.GC26361@suse.de> <1039547210.1071.26.camel@localhost.localdomain> <20021210172320.A4586@suse.de> <1039539977.14251.40.camel@irongate.swansea.linux.org.uk> <20021210170542.GB577@codemonkey.org.uk> <1039553986.1054.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039553986.1054.7.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 02:00:47AM +0500, Antonino Daplas wrote:
 > 
 > Oops, Alan beat me into it. It's basically the same as what I've got
 > except I had an i810fb specific macro.  I guess the one without the
 > macro is cleaner.

I did something similar in my pending tree, but I just made it
unconditional instead of littering lots of ifdefs.

        Dave

