Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRLLVLi>; Wed, 12 Dec 2001 16:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282373AbRLLVL3>; Wed, 12 Dec 2001 16:11:29 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:39440 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S282275AbRLLVLX>; Wed, 12 Dec 2001 16:11:23 -0500
Date: Wed, 12 Dec 2001 22:11:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011212221120.A7400@suse.cz>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com> <20011212103748.C14688@informatics.muni.cz> <20011212112548.E29229@sventech.com> <20011212172940.O14688@informatics.muni.cz> <20011212114820.F29229@sventech.com> <20011212180333.V14688@informatics.muni.cz> <20011212125323.N8227@sventech.com> <20011212220625.A7346@suse.cz> <20011212160919.R8227@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212160919.R8227@sventech.com>; from johannes@erdfelt.com on Wed, Dec 12, 2001 at 04:09:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 04:09:19PM -0500, Johannes Erdfelt wrote:
> On Wed, Dec 12, 2001, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Wed, Dec 12, 2001 at 12:53:23PM -0500, Johannes Erdfelt wrote:
> > > On Wed, Dec 12, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> > > > [l-k removed from Cc:]
> > > > 
> > > > Johannes Erdfelt wrote:
> > > > : 
> > > > : There's your problem with disconnects. Those are illegal per the specs.
> > > > : 
> > > > 	What is the maximum length?
> > > 
> > > I haven't looked at the spec lately, but I think 5 meters is the
> > > maximum. You can go longer if you use an active cable which is
> > > essentially a one port hub. It essentially acts as a repeater.
> > 
> > The problem with active cables is that they are very problematic as
> > well. The device plugged in isn't visible to Linux until the cable
> > itself is unplugged and replugged into the computer. I haven't found out
> > why yet.
> 
> That's weird. Sounds like a problem specific to that cable. It should
> just look like a hub and act as one.
> 
> Including hot plugging.

Most active extension cables don't look like hubs. They have the
electric part of the hub built in, but not the logic one. They're
invisible on the USB bus.

-- 
Vojtech Pavlik
SuSE Labs
