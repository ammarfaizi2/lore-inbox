Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVDLWim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVDLWim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVDLWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:38:37 -0400
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:14209 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S263026AbVDLWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:36:37 -0400
Date: Tue, 12 Apr 2005 18:36:23 -0400
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050412223623.GA29088@havoc.gtf.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 02:21:58PM -0700, Linus Torvalds wrote:
> 
> Yes. A tree is defined by the blobs it references (and the subtrees) but 
> it doesn't _contain_ them. It just contains a pointer to them.

A pointer to them?  You mean a SHA1 hash of them? or what?
Where is the *real* data stored?  The real files, the real patches?
Are these somewhere completely outside of git?

> > Therefore, "TREE" must be the *full* data, and since we have the following
> > definition for CHANGESET:
> 
> No. A tree is not the full data. A tree contains enough information to 
> _recreate_ the full data, but the tree itself just tells you _how_ to do 
> that. It doesn't contain very much of the data itself at all.

Perhaps I'd understand this if you tell me what "recreate" means.
If a have a SHA1 hash of a file, and I have the file, I can verify that said
file has the SHA1 hash it's supposed to have, but I can't generate the file
from it's hash...

Sorry for being stubbornly dumb, but you'll have a couple of us puzzling 
at the README ;-)

-dte
