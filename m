Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275031AbRJYPbA>; Thu, 25 Oct 2001 11:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJYPau>; Thu, 25 Oct 2001 11:30:50 -0400
Received: from rj.sgi.com ([204.94.215.100]:13973 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275031AbRJYPag>;
	Thu, 25 Oct 2001 11:30:36 -0400
Message-Id: <200110251527.f9PFRIx15728@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: mdiwan@wagweb.com (Frontgate Lab), linux-kernel@vger.kernel.org
Subject: Re: kernel compiler 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Thu, 25 Oct 2001 16:28:22 BST." <E15wmQg-0005Bl-00@the-village.bc.nu> 
Date: Thu, 25 Oct 2001 10:27:18 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> > What compiler do Alan Cox and Linus use to create the 2.4 series
> > kernels?
> 
> Im using Red Hat 2.96-85
> 
> > I am currently using RedHat's compiler gcc-2.96-85 and have been told
> > not to do so because it "breaks things" .
> 
> Generally ignore that story: 2.96-54 has problems, but not the later ones
> 
> > The question would be .. how hard is it going to be for me to upgrade to
> > gcc 3 +  and  will i get any benefit from it?  WillI loose any
> > advantages that i currently do have?
> 
> Gcc 3.0 doesn't always build correct kernels. Its very much a .0 release -
> new infrastructure, the core to do far better thinga than gcc 2.* but not
> yet the actual results as the bugs all get kicked out
> 
> > Or can i still get what i need from compiling 2.4.12 or 2.4.13 with the
> > compiler I have now?
> 
> Yeah
> -

Just for information, none of the Redhat compilers (the 2.96 leg) build
all of XFS correctly, see this bug for info:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54571

Steve


