Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWBTSxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWBTSxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBTSxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:53:40 -0500
Received: from smtp.enter.net ([216.193.128.24]:36100 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932543AbWBTSxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:53:39 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 20 Feb 2006 13:53:59 -0500
User-Agent: KMail/1.8.1
Cc: davidsen@tmr.com, nix@esperi.org.uk, mj@ucw.cz,
       linux-kernel@vger.kernel.org, chris@gnome-de.org, axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <43F7257D.80400@tmr.com> <43F9E8C2.nail4ALB11DH3@burner>
In-Reply-To: <43F9E8C2.nail4ALB11DH3@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201354.00595.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 11:05, Joerg Schilling wrote:
> Bill Davidsen <davidsen@tmr.com> wrote:
> > >If you did ever try to write reliable code that has to deal with this
> > > kind of oddities, you would understand that it is sometimes better to
> > > wait and to inform related people about the problems they caused.
> >
> > This ground has been covered. And at least in the case of filtering
> > commands, that had to be done quickly and you know it.
>
> We all know that filtering is not needeed to fix a bug. It could have been
> implemented completely relaxed and without any time pressure as the bug
> that needed fixing could have been fixed by just requiring a R/W FD to
> allow SG_IO.

In one post you complain that SG_IO is unneeded on /dev/hd* and related 
devices and in this one you say that it's all that would have been needed to 
fix a bug!

Joerg, I think it's time you stop dodging questions, shifting blame and all 
the tactics you've been using and admit that you just don't like Linux. After 
all, every time you are asked to provide a technical basis for an argument 
you have three main tactics - Dodge it entirely, misquote POSIX or say "But 
Solaris does it this way".

As you well know I've asked you for quality information I could use to try and 
fix the bug in the kernel where it munges the CDB for certain drives and am 
trying to work with you to develop a patch that will let libscg scan both the 
SCSI and ATA/ATAPI bus on Linux. I realize I'm an unknown factor here, since 
I've never found any place where my skills would come in useful on a major 
project like cdrecord or Linux, but now I have.

If you do not want the help just say such. If you just want to complain about 
problems and preach about how great Solaris is, then you are nothing but a 
feigen schweinhund and deserve to receive no more of my time.

(and yes, my German is probably quite bad. It's been a very long time since 
I've used any of it on a regular basis)

DRH
