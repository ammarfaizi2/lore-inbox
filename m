Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHPUuP>; Fri, 16 Aug 2002 16:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHPUuP>; Fri, 16 Aug 2002 16:50:15 -0400
Received: from ulima.unil.ch ([130.223.144.143]:45714 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S317024AbSHPUuO>;
	Fri, 16 Aug 2002 16:50:14 -0400
Date: Fri, 16 Aug 2002 22:54:08 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors ???
Message-ID: <20020816205408.GA16272@ulima.unil.ch>
References: <20020815204947.GB31520@ulima.unil.ch> <3024180000.1029507100@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3024180000.1029507100@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 08:11:40AM -0600, Justin T. Gibbs wrote:

> Sure it was detected.  It was also disabled because we couldn't
> talk to it at Ultra speeds.  The BIOS does not perform much if any
> I/O at Ultra speeds to CDROMs during boot, so it may not see this 
> problem.
> 
> > When I replace the 2940U by a 2940 I don't have those problem???
> 
> The 2940 doesn't run at Ultra speeds.  Your drive may work just fine
> when you slow down the bus.  Do you get similar results when you
> set the failing CDROM to 10MB/s in SCSI-Select?  Your cabling or
> termination doesn't seem to be up to snuff for Ultra speeds to
> the failing drive.

In fact, I have tested several combination, and discovered that I got
two device that can't work at 20 MB/s ???

Setting the two at 10 MB/s in BIOS, and I can boot perfectly now ;-)

Thank you very much and sorry for the trouble!

	Gr?goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
