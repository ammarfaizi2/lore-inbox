Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSDCOwi>; Wed, 3 Apr 2002 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDCOw2>; Wed, 3 Apr 2002 09:52:28 -0500
Received: from [195.53.115.72] ([195.53.115.72]:47118 "EHLO
	mailesmtp.IGAE.minhac.es") by vger.kernel.org with ESMTP
	id <S311829AbSDCOwQ>; Wed, 3 Apr 2002 09:52:16 -0500
Message-ID: <3751737A15FDD41188B40000D11C0BF204A75B7D@MAILE>
From: =?iso-8859-1?Q?=22Fern=E1ndez-Victorio_Ar=E9valo=2C_Gonzalo=22?= 
	<GFernandez-Victorio@IGAE.minhac.es>
To: "'Chris Wilson'" <chris@jakdaw.org>, linux-kernel@vger.kernel.org
Subject: RE: P4/i845 Strange clock drifting
Date: Wed, 3 Apr 2002 16:52:05 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

Maybe you could read Bernd Schubert message to this list on Wed Mar 27 2002
- 10:28:35 EST
http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.3/0557.html

HTH

Gonzalo

-----Original Message-----
From: Chris Wilson [mailto:chris@jakdaw.org]
Sent: Wednesday, April 03, 2002 4:10 PM
To: linux-kernel@vger.kernel.org
Subject: P4/i845 Strange clock drifting



Hi,

I've got a 1U 2.0 Ghz P4 rackmount server with an i845 chipset and have
noticed some strange issues with the timer. For the most part it keeps
time perfectly... but pretty often (tens of times each day) it'll have
drifted anything from a few seconds to a few minutes - during a 10 minute
period. It's always behind-time - so perhaps this is something to do with
the P4's throttling stuff? Has anyone else seen similar?

I tried to use 2.5.7-dj2 with Zwane Mwaikambo's thermal LVT support in
there but it didn't detect a local APIC on bootup (!) - I'm guessing there
needs to be an APIC for Zwane's stuff? When I tried to switch back to
2.4.18 the machine never came back - as soon as someone power cycles it
then I can do some more tests!

Regards,

Chris

-- 
Chris Wilson
chris@jakdaw.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
