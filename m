Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTIQLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 07:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTIQLx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 07:53:57 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:45188 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S262732AbTIQLxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 07:53:55 -0400
Date: Wed, 17 Sep 2003 13:53:53 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       iain d broadfoot <ibroadfo@cis.strath.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: getting a working CD-drive in 2.6
In-Reply-To: <3F628811.1010209@sbcglobal.net>
Message-ID: <Pine.LNX.4.44.0309171351210.2208-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Wes Janzen wrote:

> Stuart Longland wrote:
> 
> > iain d broadfoot wrote:
> >
> > |     ide-scsi is disabled.
> >
> > If it's an IDE drive, you'll want this _enabled_ before you'll be able
> > to write CDs.  Most of the burner software that I know of look for a
> > SCSI CD burner, not IDE.  ide-scsi is intended for making an IDE CD
> > burner appear as a SCSI device.

> Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade 
> your cdrecord tools and probably your burning GUI, if you use one.  I've 
> been burning that way for several months now.  (I'm using xcdroast, 
> though I need to start it with "-n" since I'm using cdrecord 2.01a18.)  
> This actually works better for me than ide-scsi as for some reason it 
> uses less CPU.

Just add the dev parametre to the cdrecord command line and it will work:
$ cdrecord dev=/dev/hdc
$ cdrecord dev=/dev/hdc -scanbus

You can put it in the various cd recording programs setups.

Pau

