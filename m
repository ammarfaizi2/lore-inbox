Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTLBS3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTLBS3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:29:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53892 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264311AbTLBS26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:28:58 -0500
Date: Tue, 2 Dec 2003 16:01:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Murthy Kambhampaty <murthy.kambhampaty@goeci.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: RE: XFS for 2.4
In-Reply-To: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
Message-ID: <Pine.LNX.4.44.0312021557500.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Murthy Kambhampaty wrote:

> On Tuesday, December 02, 2003 10:50 AM, Marcelo Tosatti
> [mailto:marcelo.tosatti@cyclades.com] wrote:
> 
> > > > Also I'm not completly sure if the generic changes are 
> > fine and I dont
> > > > like the XFS code in general.
> > > Ahh so the real truth comes out.
> > > 
> > > 
> > > Is there a reason for your sudden dislike of the XFS code?
> > 
> > I always disliked the XFS code. 
> > 
> > > or is this just an arbitrary general dislike for unknown or unstated
> > > reasons?
> > 
> > I dont like the style of the code. Thats a personal issue, 
> > though, and 
> > shouldnt matter.
> 
> i) Would the linux 2.4 kernel maintainer please stop trolling the XFS
> mailing list.

Sure :) 

> > 
> > The bigger point is that XFS touches generic code and I'm not 
> > sure if that 
> > can break something.
> 
> ii) This was the reason why it took so long to get it into the 2.5 series
> and in the 2.4-ac series, of course, but surely by now it has been shown
> that the changes to the generic code do not "break something". It isn't
> clear what standard is being applied here. Surely its not "the patches had
> better be shown to not break anything else AND Marcelo Tosatti must also
> like the style of the code".

Well theres not much of a standard indeed.  

> > Why it matters so much for you to have XFS in 2.4 ? 
> > 
> 
> iii) The 2.4 series kernel is the here and now, regardless of how near we
> all hope/project the 2.6 kernel to be (has Andrew Morton even taken it over
> from Linus?). Pushing 2.6 on users, and unjustifiably blocking the adoption
> of advanced features into the current linux kernel is pretty absurd. XFS has
> unmatched filesystem features (for example, it uniquely enables filesystem
> level backup of databases even when the database log is on a different
> partition than the data tables
> http://marc.theaimsgroup.com/?l=postgresql-admin&m=106641231828872&w=2).
> 
> If you can't come up with something more concrete than "I don't like your
> coding style" and "I'm not sure your patch won't break something", it seems
> only fair you take the XFS patches.

Using my non-standard and "better not to break anything else" techniques
I decide to not include it.

Its too late for it to be included in 2.4. Use 2.6 or a modified 2.4 tree.



