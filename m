Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJWBh2>; Tue, 22 Oct 2002 21:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbSJWBh2>; Tue, 22 Oct 2002 21:37:28 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:65251 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262525AbSJWBgm>;
	Tue, 22 Oct 2002 21:36:42 -0400
Date: Wed, 23 Oct 2002 02:44:00 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Rob Landley <landley@trommello.org>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
       mingo@redhat.com
Subject: Re: [STATUS 2.5]  October 21, 2002
Message-ID: <20021023014400.GA13722@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rob Landley <landley@trommello.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
	mingo@redhat.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211522.35843.landley@trommello.org> <20021022194739.GB28822@clusterfs.com> <20021022195730.GA30958@suse.de> <20021022201843.GC28822@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022201843.GC28822@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 02:18:43PM -0600, Andreas Dilger wrote:

 > 	if (doing online resize)
 > 		do something;
 > 	else
 > 		don't even see any difference;
 > 
 > The resize code does not impact any code paths in the normal operation
 > of the filesystem, and 99% could even be put into a separate module,
 > that's how detached it is from the main ext3 code.

Fairy nuff. Sounds promising.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
