Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275992AbRJBJz2>; Tue, 2 Oct 2001 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275993AbRJBJzS>; Tue, 2 Oct 2001 05:55:18 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:43012 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S275992AbRJBJzF>; Tue, 2 Oct 2001 05:55:05 -0400
Date: Tue, 2 Oct 2001 11:55:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20011002115531.A7176@suse.cz>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20010926004345.D11046@mea-ext.zmailer.org> <20010927142251.A58@toy.ucw.cz> <20011002112921.A7117@suse.cz> <20011002114801.A19015@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002114801.A19015@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Tue, Oct 02, 2001 at 11:48:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 11:48:01AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > 	Also, generic PROMISC mode still drops off received frames
> > > > 	with CRC error.
> > > 
> > > Hmm, sounds good. Someone should create tool for communication over
> > > ethernet with broken crc's. Such communication would be stealth from
> > > normal tcpdump. Do it on your provider's network to escape accounting ;^)
> > 
> > But still you'll see the number of errors on your eth card
> > skyrocketing, so you'd grow quite suspicious. 
> 
> Yep, but it would be _very_ hard for you to find the cause. You'd
> probably chase ghosts trying to replace cables, etc, never finding
> what happens.

Well, if you checked all the cables, you'd most likely find the device
capable of sending the bad CRC frames. Also, if you use a switch (not ha
hub or coax), it won't work at all.

-- 
Vojtech Pavlik
SuSE Labs
