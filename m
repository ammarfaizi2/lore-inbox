Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUACHyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 02:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUACHyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 02:54:18 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36358
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262782AbUACHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 02:54:15 -0500
Date: Fri, 2 Jan 2004 23:51:29 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Christophe Saout <christophe@saout.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
In-Reply-To: <1073047522.4239.6.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.10.10401022348030.31033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

Fair enough, and point taken.  Thanks for the clarification.

I am puzzled by the need to modify buffers on the fly inside the FSM.
This is straight out of some unpublished information, so it struck a raw
nerve.  Just be aware this tends to follow the design and could be used
for such.

Cheers,

Andre Hedrick
LAD Storage Consulting Group



On Fri, 2 Jan 2004, Christophe Saout wrote:

> Am Fr, den 02.01.2004 schrieb Andre Hedrick um 05:43:
> 
> > I am sorry but adding in a splitter to CPRM is not acceptable.
> > Digital Rights Management in the kernel is not acceptable to me, period.
> > 
> > Maybe I have misread your intent and the contents on your website.
> >
> > Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> > transport is another.  This stinks of CPRM at this level, regardless of
> > your intent.  Do correct me if I am wrong.
> 
> I can assure you I was never having DRM or anything like this in mind
> nor making fundamental changes to the IDE layer. It was just that
> ++bi_idx that bugged me. Must be a misunderstanding, sorry. :)
> 
> The only thing I'm having on my website is a device-mapper target that
> does basically the same as cryptoloop tries to. It's just about
> encrypting sensitive data on top of any other device, nothing else.
> 
> 

