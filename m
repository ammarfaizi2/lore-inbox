Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270205AbRHROyZ>; Sat, 18 Aug 2001 10:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270206AbRHROyF>; Sat, 18 Aug 2001 10:54:05 -0400
Received: from cardinal0.Stanford.EDU ([171.64.15.238]:17649 "EHLO
	cardinal0.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S270205AbRHROx5>; Sat, 18 Aug 2001 10:53:57 -0400
Date: Sat, 18 Aug 2001 07:53:52 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <fa.kmbqblv.v3uvig@ifi.uio.no>
Message-ID: <Pine.GSO.4.31.0108180744090.9012-100000@cardinal0.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Eric W. Biederman wrote:

> So the attacker has two way to attack your machine.  Attempt to break
> in while it is still running.  Put in a minimal boot cd and press
> reset and see how much is recovered.  Generally breaking should prove
> the more fruitful course, but the fact that reset preseves all of the
> memory, means it simply is not safe for someone to have physical
> access to your machine while the power is on.

if the machine is on, and you can get close to it, it's probably easier
just to use tempest radiation.  it will also work at a distance, so it's
more likely to be a threat than grabbing RAM chips.  a few points:

1.  not everyone is going to bring their James Bond RAM Reader (tm) into
your building to extract data.  a hardcore data thief, maybe, but it's not
common equipment.  everyone will have access to an IDE or SCSI disk
reader.

2.  RAM has a short window of oppurtunity.  whatever it turns out to be,
RAM degrades faster than disk.  it's not going to last while you drive it
home, unless you have a RAM refresher plugged in the cigarette lighter.

3.  encrypted swap is meant for a different threat model.  you assume that
the attacker might have access to the box at night or over a weekend,
while you're away.  RAM will be off.  if you think someone might be trying
to steal your RAM, you need better physical security.





--
"I am a great mayor; I am an upstanding Christian man; I am an
intelligent man; I am a deeply educated man; I am a humble man."
      - M. Barry, Mayor of Washington, DC

