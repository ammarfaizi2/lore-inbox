Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271214AbRH2Aq6>; Tue, 28 Aug 2001 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRH2Aqt>; Tue, 28 Aug 2001 20:46:49 -0400
Received: from mailoff.mtu.edu ([141.219.70.111]:59880 "EHLO mailoff.mtu.edu")
	by vger.kernel.org with ESMTP id <S271214AbRH2Aqk>;
	Tue, 28 Aug 2001 20:46:40 -0400
From: John Duff <jfduff@mtu.edu>
Message-Id: <200108290020.f7T0Km901301@tamarack.cs.mtu.edu>
Subject: Apollo Pro266 system freeze followup
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Aug 2001 20:20:48 -0400 (EDT)
Cc: rjh@groucho.maths.monash.edu.au, barryn@pobox.com
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed a thread on this list about a month ago regarding complete system
freezes on machines using the VIA Apollo Pro266 chipset:

http://uwsg.iu.edu/hypermail/linux/kernel/0107.3/0514.html

I too have such a system: 
(Iwill DVD266-R, two 1GHz PIIIs, 512M of Crucial PC2100, 4 IBM 75GXP 30G 
hard drives each hanging off one of the onboard IDE channels, running 
software RAID-5, Plextor CDRW),
and have seen the same thing.  I first noticed the problem when I decided
to do a stress test involving two simultaneous linux kernel compiles, 
continuously doing make clean and then make bzImage.  This will freeze
the system every time after a few hours or so, guaranteed.

Then I tried compiling a 2.4.9 kernel without SMP support, and it has
been running two simultaneous linux kernel compiles continuously for
more than two days straight on my Iwill box.  I dunno if this is very
helpful in figuring out where the bug may lie in the chipset, but I
thought it might be of interest to others with Apollo Pro266 chipset
boxes, that at least they can run reliably (keeping my fingers crossed)
on just one cpu for now.

(I don't subscribe to the list, so please CC me on any follow-ups).

-John
jfduff@mtu.edu

