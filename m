Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSDQRrS>; Wed, 17 Apr 2002 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDQRrR>; Wed, 17 Apr 2002 13:47:17 -0400
Received: from borg.org ([208.218.135.231]:12177 "HELO borg.org")
	by vger.kernel.org with SMTP id <S311320AbSDQRrR>;
	Wed, 17 Apr 2002 13:47:17 -0400
Date: Wed, 17 Apr 2002 13:47:16 -0400
From: Kent Borg <kentborg@borg.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nick@snowman.net,
        Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020417134716.D10041@borg.org>
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> <E16xrfQ-0002VF-00@the-village.bc.nu> <20020417102722.B26720@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Apr 17, 2002 at 10:27:22AM -0700, Jeff V. Merkey wrote:
> From my analysis with 3Ware at 32 drive configurations, you really
> need to power the drives from a separate power supply is you have 
> more than 16 devices.  They really suck the power during initial 
> spinup.

It seems an obvious help would be to have the option of spinning up
the drives one at a time at 2-3 second intervals.  I know a fast drive
doesn't get up to speed in 3 seconds, but the nastiest draw is going
to be over by then.

A machine with 32 drives is pretty serious stuff and probably isn't
booting in a few seconds anyway--another 60-some seconds might be a
desirable option.

Does this exist anywhere?  Would it have to be a BIOS feature?


-kb
