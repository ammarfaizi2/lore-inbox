Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbUK3Xe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUK3Xe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUK3XeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:34:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262459AbUK3XdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:33:09 -0500
Date: Tue, 30 Nov 2004 23:33:06 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130233306.GA5752@parcelfarce.linux.theplanet.co.uk>
References: <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <8219.1101828816@redhat.com> <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org> <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org> <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> <oracszrp7t.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oracszrp7t.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 07:39:34PM -0200, Alexandre Oliva wrote:
> Sure, we could take headers from linux-*/include/user and install them
> in /usr/include/kernel, but then includes in there that reference
> other headers in user/ or in asm-<arch>/ will cease to work.

I covered this with an evil sed script earlier in the thread.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
