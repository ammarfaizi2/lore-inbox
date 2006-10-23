Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751980AbWJWQJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWJWQJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWJWQJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:09:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751980AbWJWQJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:09:55 -0400
Date: Mon, 23 Oct 2006 09:09:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andi Kleen <ak@suse.de>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
 <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2006, Geert Uytterhoeven wrote:
> > 
> > Would be a worthy goal imho. Can it be done with scripts? 
> 
> Making them self-contained or checking whether they are? :-)
> 
> The latter is simple, just compile each of them into dummy object files, which
> should give no compile errors.

It's _not_ simple. Not at all.

We have tons of issues that depend on config variables and architecture 
details. 

It's hard.

		Linus
