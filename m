Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135987AbRA1APl>; Sat, 27 Jan 2001 19:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135980AbRA1APY>; Sat, 27 Jan 2001 19:15:24 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:49333 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S135979AbRA1APK>;
	Sat, 27 Jan 2001 19:15:10 -0500
Date: Sat, 27 Jan 2001 19:14:20 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
Subject: ECN: Clearing the air (fwd)
Message-ID: <Pine.GSO.4.30.0101271914000.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just proves i am not on lk

---------- Forwarded message ----------
Date: Sat, 27 Jan 2001 19:05:38 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: linux-kernel@vger.rutgers.edu
Cc: netdev@oss.sgi.com
Subject: ECN: Clearing the air


On Fri, 26 Jan 2001 15:29:51 +0000, James Sutherland wrote:
> Except you can't retry without ECN, because DaveM wants to do a
> Microsoft and force ECN on everyone, whether they like it or not.

I think there is some serious misinformation going on here.

Hopefully, this will straighten things out:

- ECN is not a standard that DaveM came up with, or some cabal within
the Linux community pulled out of a hat. It was the Internet Engineering
Task Force that endorsed it. If you want to blame anybody,
blame the IETF. Specifically you should also blame Sally Floyd and KK
Ramakrishnan who proposed it after years of research. In case those
names dont ring a bell look, them up in the internet whos-who almanac.
Dont ask me where you'll find one.
In case the IETF doesnt ring a bell either to some people, it is the same
standard body that made the internet happen. It is the same standard body
that also ensures that although the internet is anarchical in nature, there
are some simple governing rules that should be defined to keep  it alive.
They are called protocols. The IETF has a very simple motto "we believe in
running code ...". [Although that's not neccesarily true these days, but
let's not tread there].
People, Linux is no longer a baby. We are leaders as far as the internet
is concerned. We are there first. We set trends and other follow. We have
"running code" to flush out all the heretics out there.
We have the best TCP/IP people in the world today coding for you and i.
Blaspheming with "DaveM wants to pull a MS" doesnt help. We need to
encourage these kind of activities because we are making the internet a
better place. Yes, Al Gore might have funded some good causes on the
internet, but today _we_ make them happen.

- ECN is a good thing. It has been proven for years to be a good thing.
Standards normally go through a experimental phase before becoming
proposed standard. If you dont want it turn it off.

- ECN is going to become a proposed standard perhaps by this
coming IETF at Mineapolis.

- A lot of OS vendors and good router vendors will be deploying ECN soon.
There is nothing wrong with Linux being first. We code in the open, others
prefer press releases.

- ECN does not break things. It's brain damaged firewalls, Intrusion
detection systems, and load balancers that should be shot.
One intrusion detection "expert" was quoted suggesting the blocking of ECN
bits should be blocked because "nmap uses them" to probe systems.
Any commercial non-open-source entity  designing and abusing reserved
fields should at least have the courtesy of providing a config option to
stop that abuse. If it was open source we would have fixed their sins.

- Any design which blatantly ASSumes that "reserved" means no one should
use something simply amazes me. The collegiate dictionary definition of
"reserved" is:

---------------------
               Main Entry: reserve
               Pronunciation: ri-'z&rv
               Function: transitive verb
               Inflected Form(s): reserved; reserving
               Etymology: Middle English, from Middle French reserver,
               from Latin reservare, literally, to keep back, from re- +
               servare to keep -- more at CONSERVE
               Date: 14th century
               1 a : to hold in reserve : keep back <reserve grain for
               seed> b : to set aside (part of the consecrated elements)
               at the Eucharist for future use c : to retain or hold over
               to a future time or place : DEFER <reserve one's judgment
               on a plan> d : to make legal reservation of
               2 : to set or have set aside or apart <reserve a hotel
               room> synonym see KEEP - reservable /-'z&r-v&-b&l/
               adjective
-----------------------

Now where is the ambiguity in that?

And where really is the ambiguity in the meaning of a TCP RST?
Maybe an analogy in a very ambiguos protocol called "English Language"
would help.
The word "no" in response to the packet "davem please add an extra meaning
to RST".  Where is the ambiguity in that?

phew! just my 2 .ca cents

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
