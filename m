Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVARQqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVARQqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVARQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:46:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45788 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261345AbVARQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:40:04 -0500
Date: Tue, 18 Jan 2005 16:40:03 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI patches not being reviewed
Message-ID: <20050118164002.GR30982@parcelfarce.linux.theplanet.co.uk>
References: <20050118022031.GL30982@parcelfarce.linux.theplanet.co.uk> <20050118062721.GA8951@kroah.com> <20050118122126.GM30982@parcelfarce.linux.theplanet.co.uk> <20050118162908.GA12553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118162908.GA12553@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 08:29:08AM -0800, Greg KH wrote:
> On Tue, Jan 18, 2005 at 12:21:26PM +0000, Matthew Wilcox wrote:
> > Yes, the PCI Express bridge driver is quite buggy.
> 
> It was posted a number of times to lkml in December, and it was
> commented on by a few different people, and the patch went through a few
> different revisions.  It also was in the -mm tree for awhile.

But since it didn't go to the linux-pci mailing list, I never saw it.
So I never reviewed it.

> > I also think it's the wrong approach to take -- weren't you working on
> > a generic way to have multiple drivers attach to the same device?
> 
> That's what the patch allows to happen.  I think it's the right
> approach, what do you think it should do?

Ah, I thought you were talking about something for the generic device
model.  If you don't have that in mind, then a multiplexing driver is
probably the right way to do it.

> > That would certainly help; I'm not sure how anyone has time to read
> > linux-kernel.  Here's a patch:
> 
> Hm, in sleeping on it, I think I'll leave it, as it's worked out just
> fine for me for the past 2+ years I've been the PCI maintainer, this has
> been the first it has come up.

Well, no, I mentioned it to you before, you said you'd do something
about it, and nothing happened.  Hence me now talking to you in public.

> But if it really annoys you, how about
> just adding another L: entry for it, so people can choose where they
> want to go?

That doesn't make much sense.  Either you want things to be reviewed
or you don't.  If you want them reviewed, you send them to linux-pci.
Why should it be any different from linux-scsi, linux-ide, netdev or
linux-mm?

> Oh, and you forgot the Signed-off-by: line :)

Do you remember what Signed-off-by is for?

	Developer's Certificate of Origin 1.0

	By making a contribution to this project, I certify that:

	(a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
	    indicated in the file; or

	(b) The contribution is based upon previous work that, to the best
	    of my knowledge, is covered under an appropriate open source
	    license and I have the right under that license to submit that
	    work with modifications, whether created in whole or in part
	    by me, under the same open source license (unless I am
	    permitted to submit under a different license), as indicated
	    in the file; or

	(c) The contribution was provided directly to me by some other
	    person who certified (a), (b) or (c) and I have not modified
	    it.

What license is MAINTAINERS under?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
