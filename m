Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSDCOKm>; Wed, 3 Apr 2002 09:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311721AbSDCOKc>; Wed, 3 Apr 2002 09:10:32 -0500
Received: from gateway.wapmx.com ([217.169.1.89]:45710 "EHLO horizon.wapmx.com")
	by vger.kernel.org with ESMTP id <S311710AbSDCOKQ>;
	Wed, 3 Apr 2002 09:10:16 -0500
Date: Wed, 3 Apr 2002 15:10:12 +0100
From: Chris Wilson <chris@jakdaw.org>
To: linux-kernel@vger.kernel.org
Subject: P4/i845 Strange clock drifting
Message-Id: <20020403151012.5061d247.chris@jakdaw.org>
Organization: jakdaw.org
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
