Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTJSTuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJSTuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:50:25 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34053
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262176AbTJSTuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:50:17 -0400
Date: Sun, 19 Oct 2003 12:44:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hans Reiser <reiser@namesys.com>
cc: Erik Andersen <andersen@codepoet.org>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'nikita@namesys.com '" <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
In-Reply-To: <3F92D4FA.40405@namesys.com>
Message-ID: <Pine.LNX.4.10.10310191230340.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay Hans,

First if people will bother to remember that everything about storage is a
"LIE".  Then the rest of the issue will be simple.

The private version of DCO was jokingly referred to ad "dollars for
gigabytes".

Designed for the idiot and moron system administrator who only knows how
to apply a snapshot image to a drive.  These are the special class of SA's
who because the system was purchased w/ a 20MB drive, they could only
install another 20MB drive.

The reality as Eric (maxtor) pointed out, drive companies can not keep
drive lifetimes that long.  However the cheap path the drive industry took
was to cheat the warrenty.  Now with DCO (vendor version), they could
provide any drive as a "de-stroked" capacity they want.  Thus recall I
added but now may have been removed "STROKE" option.

Now the private version can alter the entire IDENTIFY page.

So a 200GB drive can be made to look and report as that 20GB drive.
This includes faking (the big lie) the model, capacity, features,
revision, and firmware.  Additionally listing such "LIES" on company web
sites as valid products.

Now where did the joke come from?  If some one like me was to announce
they have the means to detect such a DCO event, which I can not.  That
person could sell at a price a tool to make disks magically grow in
capacity.

So depending on how much you were willing to pay and how much the
individual want to charge, they could gradually expand your drive to full
capacity (native) and charge you for each step.

So now that the story of the DCO is out, have fun finding it.  Also do
thank the lamers and brain dead SA's who could not live with a simple HPA,
to force the creation of yet another storage "LIE".

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 19 Oct 2003, Hans Reiser wrote:

> Any time you want to just spell it out in plain english for the rest of 
> the lkml, please do so.....
> 
> Hans
> 
> Andre Hedrick wrote:
> 
> >Erik,
> >
> >Nice quoting of the "public" version, now what did I really mean?
> >Obviously you, Eric, and the rest of the mailing list were not in the
> >smoke filled back room when Compaq and Dell were formalizing the proposal.
> >
> >Cheers,
> >
> >Andre Hedrick
> >LAD Storage Consulting Group
> >
> >On Sun, 19 Oct 2003, Erik Andersen wrote:
> >
> >  
> >
> >>On Sun Oct 19, 2003 at 12:27:30PM +0400, Hans Reiser wrote:
> >>    
> >>
> >>>What is DCO oh cryptic industry insider.;-)
> >>>      
> >>>
> >>See "6.21 Device Configuration Overlay feature set" in 
> >>the ATA6 spec...
> >>
> >>"The optional Device Configuration Overlay feature set allows a
> >>utility program to modify some of the optional commands, modes,
> >>and feature sets that a device reports as supported in the
> >>IDENTIFY DEVICE or IDENTIFY PACKET DEVICE command response as
> >>well as the capacity reported."
> >>
> >> -Erik
> >>
> >>--
> >>Erik B. Andersen             http://codepoet-consulting.com/
> >>--This message was written using 73% post-consumer electrons--
> >>
> >>    
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> 
> 
> -- 
> Hans
> 
> 

