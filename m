Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285433AbRLGGro>; Fri, 7 Dec 2001 01:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285432AbRLGGrh>; Fri, 7 Dec 2001 01:47:37 -0500
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:28626 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282784AbRLGGrX>; Fri, 7 Dec 2001 01:47:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com
Subject: Re: [kbuild-devel] Converting the 2.4 kernel to kbuild 2.5
Date: Thu, 6 Dec 2001 15:24:36 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <stoffel@casc.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16C2HM-0002JR-00@the-village.bc.nu> <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there> <20011206195710.A1949@thyrsus.com>
In-Reply-To: <20011206195710.A1949@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011207064722.DIYZ17345.femail42.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 December 2001 07:57 pm, Eric S. Raymond wrote:
> Rob Landley <landley@trommello.org>:
> > P.S.  Can we seperate "add new subsystem y prime" and "remove old
> > subsystem y".  LIke the new and old SCSI error handling, which have been
> > in the tree in parallel for some time?  Did I hear Eric ever suggest
> > removing the old configurator for 2.4?  Anybody?
>
> The whole point of putting the new configurator in would be to be able
> to drop the old one out.

Eric, I hate to break this to you, but they ain't gonna do it.

I like the new configurator, but It wouldn't matter if the thing cured 
cancer.  Removing an old system from a stable series just doesn't happen.  We 
don't even remove stuff that's clearly broken, we just mark it dangerous.  
Even backporting the new configurator as an optional paralell subsystem is 
pretty controversial.  Technical merit aside, too many people are still 
shellshocked over the VM thing.

Now that 2.4 has been handed off to Marcelo, people are looking for LESS 
changes out of the stable series.  To be blunt, we haven't really HAD a 
stable series in 2.4 yet.  Even 2.4.15 was almost a "dontuse" kernel due to 
the shutdown sync thing.  After 11 months of frustration, people are just a 
TOUCH sensitive on this issue.  Don't prod the sore tooth here, it's all pain 
and no benefit...

> But that would be strictly Marcelo's call.

He's going to say no.  But by all means, ask him if that will resolve the 
issue.  (I'll even refrain from calling it a cop-out, if this will help. :)

> It would be up to him to decide whether the tradeoff were worth it.

Worth it for who?

If the whole point of merging the new configurator into 2.4 is to drop the 
old one, and we can confirm that's not going to happen (by asking Marcelo), 
then there is no point in trying to merge the new configurator into 2.4.  
(All syllogisms have three parts, therefore this is not a syllogism.)

Follow 2.5 and drop 2.4 support or hand it off to somebody else if you don't 
want to do it.  A better configurator is yet another reason for people to 
migrate to 2.6 when it comes out.  This is a good thing...

Rob
