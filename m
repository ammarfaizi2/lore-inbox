Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUEVQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUEVQRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEVQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:17:03 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261610AbUEVQRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:17:00 -0400
Date: Sat, 22 May 2004 17:22:56 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
To: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>,
       system <system@eluminoustechnologies.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
References: <200405221257.28570.system@eluminoustechnologies.com>
 <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
Subject: Re: hda Kernel error!!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>:
> 
> 
> On Sat, 22 May 2004, system wrote:
> 
> > Hello All,
> >  In that I found warning about kernel error!!
> > 
> > WARNING:  Kernel Errors Present
> >    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
> >    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  1Time(s)
> > 
> > What is this error?
> > Dose this indicate error on hda?
> > Should I replace hda?OR it's different from all these?
> > Please help thank you...
> 
> Mayby I'm not kernel expert yet, but IMVHO it looks like hardware (hard 
> drive) problem. 

It means the disk received a command it didn't support.  It's easy to
trigger by disabling S.M.A.R.T. and then requesting S.M.A.R.T. data, for
example.

> You could do some tests on this drive using programs like badblocks or 
> similar. I have problem like that and in this case it was hardware 
> problem (drive had guarantee, and manufactor replaced it, so it had to be broken).
> So AFAIK this type of error indicates serious problem with hardware, 
> unfortunately.

It does not necessarily indicate a serious problem.  Are you sure your
error messages were exactly the same?

John.
