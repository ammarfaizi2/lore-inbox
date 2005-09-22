Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVIVUhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVIVUhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIVUhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:37:01 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:6783 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751096AbVIVUhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:37:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=oHfU4m8Yl63viEPWHKuq2iEVzdTJEsRSxziAq//SeQngwraAPs19+EC7pr9UkBDT4JVcKLGy5NXR3qRnL69rxDaeM2RBBSffqp2gHWCIh6lyZeSTU31upbbd6K1kWeJRNUuMz76C1L9DE02KpdxpLy688K+Dl4/NB8zFnIk6DFc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: readme-update-from-the-stone-age.patch added to -mm tree
Date: Thu, 22 Sep 2005 22:27:29 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200509202336.j8KNak00013479@shell0.pdx.osdl.net> <200509211630.33242.blaisorblade@yahoo.it> <2cd57c900509211736414cea32@mail.gmail.com>
In-Reply-To: <2cd57c900509211736414cea32@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509222227.29885.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 02:36, Coywolf Qi Hunt wrote:
> On 9/21/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Wednesday 21 September 2005 04:15, Coywolf Qi Hunt wrote:
> > > On 9/21/05, akpm@osdl.org <akpm@osdl.org> wrote:
> > > > The patch titled
> > > >
> > > >      README update from the stone age
> > > >
> > > > has been added to the -mm tree.  Its filename is
> > > >
> > > >      readme-update-from-the-stone-age.patch
> > > >
> > > >
> > > >
> > > > @@ -199,6 +199,9 @@ COMPILING the kernel:
> > > >     are installing a new kernel with the same version number as your
> > > >     working kernel, make a backup of your modules directory before
> > > > you do a "make modules_install".
> > > > +   In alternative, before compiling, edit your Makefile and change
> > > > the +   "EXTRAVERSION" line - its content is appended to the regular
> > > > kernel +   version.
> > >
> > > This is wrong. You expect users to both do menuconfig and edit top
> > > Makefile manually?  What is the local version for then?
> >
> > Ok, yes, feel free to upgrade this to the use of CONFIG_LOCALVERSION. Or
> > I can do it as well.
> > --

> CONFIG_LOCALVERSION is for normal users while "EXTRAVERSION" is for
> developers to maintain different kernel trees.
Ok, Randy Dunlap just fixed it up.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
