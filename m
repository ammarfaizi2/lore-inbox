Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVBSHxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVBSHxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 02:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVBSHxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 02:53:46 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:28296 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261648AbVBSHxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 02:53:43 -0500
Date: Sat, 19 Feb 2005 07:53:16 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: dtor_core@ameritech.net
cc: Vojtech Pavlik <vojtech@suse.cz>, "d.c" <aradorlinux@yahoo.es>,
       "David S. Miller" <davem@davemloft.net>, seanlkml@sympatico.ca,
       tytso@mit.edu, vonbrand@inf.utfsm.cl, cfriesen@nortel.com,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
In-Reply-To: <d120d500050218143572af23dd@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0502190750500.21429@hermes-1.csi.cam.ac.uk>
References: <seanlkml@sympatico.ca>  <4912.10.10.10.24.1108675441.squirrel@linux1>
  <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl> 
 <1451.10.10.10.24.1108713140.squirrel@linux1>  <20050218162729.GA5839@thunk.org>
  <4075.10.10.10.24.1108751663.squirrel@linux1>  <20050218214555.1f71c2e4.aradorlinux@yahoo.es>
  <20050218131326.650c77ad.davem@davemloft.net> 
 <Pine.LNX.4.60.0502182133490.30371@hermes-1.csi.cam.ac.uk> 
 <20050218221819.GA3864@ucw.cz> <d120d500050218143572af23dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005, Dmitry Torokhov wrote:
> On Fri, 18 Feb 2005 23:18:19 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Fri, Feb 18, 2005 at 09:34:47PM +0000, Anton Altaparmakov wrote:
> > > On Fri, 18 Feb 2005, David S. Miller wrote:
> > > > On Fri, 18 Feb 2005 21:45:55 +0100
> > > > "d.c" <aradorlinux@yahoo.es> wrote:
> > > >
> > > > > 2) And more important, *nobody* works against "linus' bk head".
> > > >
> > > > I do, %100 exclusively, for all the networking and sparc
> > > > development.
> > > >
> > > > I never work against the -mm tree.
> > >
> > > Dito.  All my kernel development happens against Linus' bk head and I
> > > almost never work against -mm tree.
> > 
> > Same here, I work on Linus's bk head and all the changes go to -mm for
> > testing first, then to Linus for inclusion.
> 
> I guess there is a perception that developers/maintainers are working
> against -mm because all maintainers trees are automatically pulled by
> Andrew. And when someone doing stuff on somewhat regular basis he/she
> tends to do it against maintainer's tree thus making patches suitable
> for -mm as well.

Ah yes, that is possible.  However at least for me I work against Linus' 
BK head, but my developmental NTFS tree is pulled by Andrew for -mm.  When 
I consider a release ready I request inclusion into Linus' tree.  For 
non-ntfs stuff I generally send to Andrew for -mm (like the loop driver 
fallback to file write patch I sent him a few days ago) and he can merge 
it into mainline later.

I imagine it is simillar for most maintainers trees.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
