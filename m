Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUKQQ37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUKQQ37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUKQQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:29:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:52117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262369AbUKQQ2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:28:46 -0500
Date: Wed, 17 Nov 2004 08:28:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: GPL version, "at your option"?
In-Reply-To: <1100704183.32677.28.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411170822200.2222@ppc970.osdl.org>
References: <1100614115.16127.16.camel@ghanima> 
 <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de> 
 <Pine.LNX.4.58.0411160746030.2222@ppc970.osdl.org>
 <1100704183.32677.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Alan Cox wrote:
> 
> All the code I submitted I've submitted under the GPL, the real GPL not
> the Linus one.

Sorry, but the "or any later version" is not even _part_ of the GPL, much
less a "real one". It's part of the _suggested_ _header_ of a file, not 
the license. Look at it yourself: it comes clearly after the "END OF TERMS 
AND CONDITIONS", and it's in the "How to apply these terms to your new 
program".

In other words, if you didn't have that "v2 or later" in your original 
patches, they were _always_ just the regular GPLv2.

That said, when I clarified (and I do want to make clear that the header 
on the COPYING file is a _clarification_, not a change of license) it, I 
told people that if they disagreed with me, they should send in patches 
saying "v2 or later" to their own code.

Just because there may have been confused people (like you) who thought 
that the "later version" thing was part of the license. It's not. It has 
never been. The actual _license_ part is very clear:

	If the Program specifies a version number of this License which
	applies to it and "any later version", you have the option of
	following the terms and conditions either of that version or of
	any later version published by the Free Software Foundation.

Note the "IF". Linux _never_ had the "v2 or later" clause, so that "if" 
was never an issue, and the clarification on top of the COPYING file 
really _is_ just a clarification.

Alan, you need to learn to read, and not make assumptions. 

		Linus
