Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVIUPU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVIUPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIUPU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:20:27 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:24235 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751036AbVIUPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:20:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tqeDTDeW/+TwZYPz9iggI/lPjIDlixrcWJSnVJNrEerR2DAJwTBcXKAQWT2NjQg62x3i4SGSSYqbhTnVTOurQwqheFso6FaJOZ4+/Earw7YdV1htsy/+2DpjeHzvNJuleFhJP4OpdYGMKT3FsRvJAhAPOMNwA+zvgQNQI83Lxuo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: coywolf@gmail.com
Subject: Re: readme-update-from-the-stone-age.patch added to -mm tree
Date: Wed, 21 Sep 2005 16:30:32 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200509202336.j8KNak00013479@shell0.pdx.osdl.net> <2cd57c9005092019154758c826@mail.gmail.com>
In-Reply-To: <2cd57c9005092019154758c826@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211630.33242.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 04:15, Coywolf Qi Hunt wrote:
> On 9/21/05, akpm@osdl.org <akpm@osdl.org> wrote:
> > The patch titled
> >
> >      README update from the stone age
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      readme-update-from-the-stone-age.patch
> >
> >

> > @@ -199,6 +199,9 @@ COMPILING the kernel:
> >     are installing a new kernel with the same version number as your
> >     working kernel, make a backup of your modules directory before you
> >     do a "make modules_install".
> > +   In alternative, before compiling, edit your Makefile and change the
> > +   "EXTRAVERSION" line - its content is appended to the regular kernel
> > +   version.

> This is wrong. You expect users to both do menuconfig and edit top
> Makefile manually?  What is the local version for then?
Ok, yes, feel free to upgrade this to the use of CONFIG_LOCALVERSION. Or I can 
do it as well.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
