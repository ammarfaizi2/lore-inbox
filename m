Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSHPOIN>; Fri, 16 Aug 2002 10:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSHPOIN>; Fri, 16 Aug 2002 10:08:13 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:48137 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S318368AbSHPOIN>; Fri, 16 Aug 2002 10:08:13 -0400
Date: Fri, 16 Aug 2002 08:11:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors ???
Message-ID: <3024180000.1029507100@aslan.scsiguy.com>
In-Reply-To: <20020815204947.GB31520@ulima.unil.ch>
References: <20020815204947.GB31520@ulima.unil.ch>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And my first CD-ROM on the 2940U card isn't detected at all???

Sure it was detected.  It was also disabled because we couldn't
talk to it at Ultra speeds.  The BIOS does not perform much if any
I/O at Ultra speeds to CDROMs during boot, so it may not see this 
problem.

> When I replace the 2940U by a 2940 I don't have those problem???

The 2940 doesn't run at Ultra speeds.  Your drive may work just fine
when you slow down the bus.  Do you get similar results when you
set the failing CDROM to 10MB/s in SCSI-Select?  Your cabling or
termination doesn't seem to be up to snuff for Ultra speeds to
the failing drive.

--
Justin
