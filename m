Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277262AbRJVRfs>; Mon, 22 Oct 2001 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277255AbRJVRem>; Mon, 22 Oct 2001 13:34:42 -0400
Received: from hatrack.unc.edu.ar ([170.210.248.6]:21958 "EHLO
	hatrack.unc.edu.ar") by vger.kernel.org with ESMTP
	id <S277230AbRJVRda>; Mon, 22 Oct 2001 13:33:30 -0400
Date: Mon, 22 Oct 2001 14:29:23 -0300 (ART)
From: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
To: <linux-kernel@vger.kernel.org>
Subject: kjournald and disk sleeping
Message-ID: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi. first of all, I'm not suscribed to the mailing list, so cc to
me in the replies. thanks. and I'm running 2.4.10.

	what I'm doing is to try to put the disks to sleep at night, or
when I'm not using the machine. I found what proceses to shutdown, mainly
those that do things from time to time, like the MTA. then I send a STOP
signal to kupdated. so far, so good. that works.

	then I switched to ext3 and kjournald started to appear on the
processes list. and it commits the transactions very often. I know I can
set the commit interval to a high value, but both I don't know exactly
how, and I think that it's not the solution I need. sending STOP signals
to kjournald doesn't work, it seems to ignore them. what can I do?

	One thing I thought: how is this supposed to work on laptops? can
they be suspended? a question related to this one: I also have ACPI turned
on and APM turned off. how can I switch to stanby states? is there a way?
again, how does it works on laptops?

	remember to cc to me. bye.

-- 
"y, bueno, yo soy muy ilogico. lo que pasa es que ustedes me toman
demasiado en serio"
                                          --JLB

