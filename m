Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRLLVJi>; Wed, 12 Dec 2001 16:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282212AbRLLVJ2>; Wed, 12 Dec 2001 16:09:28 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:25093 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S282222AbRLLVJT>; Wed, 12 Dec 2001 16:09:19 -0500
Date: Wed, 12 Dec 2001 16:09:19 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011212160919.R8227@sventech.com>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com> <20011212103748.C14688@informatics.muni.cz> <20011212112548.E29229@sventech.com> <20011212172940.O14688@informatics.muni.cz> <20011212114820.F29229@sventech.com> <20011212180333.V14688@informatics.muni.cz> <20011212125323.N8227@sventech.com> <20011212220625.A7346@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212220625.A7346@suse.cz>; from vojtech@suse.cz on Wed, Dec 12, 2001 at 10:06:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Dec 12, 2001 at 12:53:23PM -0500, Johannes Erdfelt wrote:
> > On Wed, Dec 12, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> > > [l-k removed from Cc:]
> > > 
> > > Johannes Erdfelt wrote:
> > > : 
> > > : There's your problem with disconnects. Those are illegal per the specs.
> > > : 
> > > 	What is the maximum length?
> > 
> > I haven't looked at the spec lately, but I think 5 meters is the
> > maximum. You can go longer if you use an active cable which is
> > essentially a one port hub. It essentially acts as a repeater.
> 
> The problem with active cables is that they are very problematic as
> well. The device plugged in isn't visible to Linux until the cable
> itself is unplugged and replugged into the computer. I haven't found out
> why yet.

That's weird. Sounds like a problem specific to that cable. It should
just look like a hub and act as one.

Including hot plugging.

JE

