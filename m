Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbULATyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbULATyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbULATyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:54:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261429AbULATyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:54:52 -0500
Date: Wed, 1 Dec 2004 19:54:50 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041201195450.GH5752@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org> <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org> <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org> <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 05:41:25PM -0200, Alexandre Oliva wrote:
> Anyhow, all of this is beyond the point.  I see you've decreed that
> people can introduce `user' directories in the kernel now.  Would you
> please reconsider and choose a dir name that would enable the same ABI
> headers to be used by kernel and userland, without adding a directory
> to /usr/include that has no indication that it comes from the kernel?

As I've said before, this can be fixed with a sed script.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
