Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDQRuQ>; Wed, 17 Apr 2002 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311433AbSDQRuP>; Wed, 17 Apr 2002 13:50:15 -0400
Received: from ns.snowman.net ([63.80.4.34]:28946 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S311424AbSDQRuO>;
	Wed, 17 Apr 2002 13:50:14 -0400
Date: Wed, 17 Apr 2002 13:48:24 -0400 (EDT)
From: <nick@snowman.net>
To: Kent Borg <kentborg@borg.org>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <20020417134716.D10041@borg.org>
Message-ID: <Pine.LNX.4.21.0204171348110.3300-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's fairly common in SCSI raid setups, however I've never seen it for
IDE.
	Nick

On Wed, 17 Apr 2002, Kent Borg wrote:

> 
> On Wed, Apr 17, 2002 at 10:27:22AM -0700, Jeff V. Merkey wrote:
> > From my analysis with 3Ware at 32 drive configurations, you really
> > need to power the drives from a separate power supply is you have 
> > more than 16 devices.  They really suck the power during initial 
> > spinup.
> 
> It seems an obvious help would be to have the option of spinning up
> the drives one at a time at 2-3 second intervals.  I know a fast drive
> doesn't get up to speed in 3 seconds, but the nastiest draw is going
> to be over by then.
> 
> A machine with 32 drives is pretty serious stuff and probably isn't
> booting in a few seconds anyway--another 60-some seconds might be a
> desirable option.
> 
> Does this exist anywhere?  Would it have to be a BIOS feature?
> 
> 
> -kb
> 

