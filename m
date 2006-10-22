Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWJVW7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWJVW7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWJVW7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:59:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54939 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750831AbWJVW7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:59:44 -0400
From: Andi Kleen <ak@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: dealing with excessive includes
Date: Mon, 23 Oct 2006 00:59:23 +0200
User-Agent: KMail/1.9.5
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061020091302.a2a85fb1.rdunlap@xenotime.net> <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230059.23806.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 19:58, Geert Uytterhoeven wrote:
> On Fri, 20 Oct 2006, Randy Dunlap wrote:
> > Yes, we have lots of header include indirection going on.
> > I don't know of a good tool to detect/fix it.
> 
> BTW, what about making sure all header files are self-contained (i.e. all
> header files include all stuff they need)? This would make it easier for the
> users to know which files to include.

Would be a worthy goal imho. Can it be done with scripts? 

-Andi
