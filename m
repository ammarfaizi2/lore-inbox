Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265312AbSJaTKt>; Thu, 31 Oct 2002 14:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbSJaTKn>; Thu, 31 Oct 2002 14:10:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265306AbSJaTKi>;
	Thu, 31 Oct 2002 14:10:38 -0500
Subject: Re: [lkcd-general] Re: What's left over.
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Dave Craft <dcraft@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0210311023270.983-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0210311023270.983-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 11:16:50 -0800
Message-Id: <1036091810.3365.11.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 10:45, Patrick Mochel wrote:
> 
> So, this is precisely where something like OSDL's Carrier Grade and Data 
> Center working groups can come into play, amazingly enough. 
> 
> By now, nearly everyone has heard about the working groups and nearly
> every developer that has, despises them. Even I resist association with
> them. But, they can have some real value to the vendors and the OEMs in 
> exactly the way you describe. 
>
> Take for example DCL. It's a kernel tree with several base patches 
> intended to make Linux better in the data center. The base is not fancy, 
> and includes things like LKCD and kdb (I think). It's actively maintained 
> and updated more often than Linus makes a release (by virtue of 
> bitkeeper).

LKCD is in and I try to keep it up to date with the patch stream.
KDB is not in yet, because the current posted patches are not up to date
to apply cleanly against 2.5.44 or 2.5.45.

> The intent is to later have multiple child trees that implement features
> for a specific application space (e.g. databases), while maintainig the
> same base set of features. People wishing to use the most recent kernel 
> with those features can use the DCL tree directly. Or an OEM FAE can use 
> the tree to build something for the vendor, or add extra features.

CGL hasn't decided what they want to change to.
DCL is going to have one tree focused on databases.

> Note that it's not a distribution. We don't even make real releases, since 
> we don't create tarballs or patches (it's only in BK, which actually kinda 
> sucks). It's merely a means to have these features actively maintained and 
> kept in synch. 

For DCL there is both a bitkeeper tree bk://bk.osdl.org/dcl-2.5 and
regular snapshots available on sourceforge
http://osdldcl.sourceforge.net
 
> And really, that's what everyone wants. Linus doesn't want the features,
> as don't other developers, regardless of the Buzzword or Coolness factors.
> Some vendors and users do want them. The developers of the features and
> distributors of features don't want to deal with the tedium and pain of
> updating patches each and every release.
> 
> In the end, it comes down to the fact that Linus's tree is Linus's tree. 
> Other people can have their trees. I'm not going to tell you go off and 
> make your own if you want those features so bad, because I know what a 
> pain in the ass it is, and I know having someone else do it is a lot 
> easier.
> 

FYI the criteria I apply for what goes into DCL is:
* Applys to large systems and databases
* Vendor support
* Conforms to Linux standard style
* Active project and maintainer that accepts feedback
* Community rejection has been mostly positive.


> DCL and CGL have their trees, for purposes probably very very similar to 
> what your customers need. I encourage you to check them out and work with 
> them (or talk to people in your company that are). Try and make it work, 
> and everyone can be happy (relativey). And, if DCL and CGL aren't 
> satisfying the space that you need, please speak up to OSDL and the 
> working groups. People are listening, and willing to take your suggestions 
> into consideration. 
> 
> Relevant URLs:
> 
> http://osdl.org/projects/cgl/
> http://osdl.org/projects/dcl/

Stephen Hemminger
Data Center Linux (DCL) Maintainer/Coordinater


