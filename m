Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276278AbRJGK5K>; Sun, 7 Oct 2001 06:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276297AbRJGK5A>; Sun, 7 Oct 2001 06:57:00 -0400
Received: from mail.physics.ox.ac.uk ([163.1.244.140]:40452 "EHLO
	janus.physics.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S276278AbRJGK4p>; Sun, 7 Oct 2001 06:56:45 -0400
Date: Sun, 7 Oct 2001 11:57:12 +0100
From: Tim Stadelmann <Tim.Stadelmann@physics.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Dell Latitude C600 suspend problem
Message-ID: <20011007115712.A4357@univn10.univ.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-AVtransport: scanmails_remote
X-AVwrapper: AMaViS (http://www.amavis.org/)
X-AVscanner: Sophos sweep (http://www.sophos.com/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

A couple of days ago there was a discussion about a problem introduced
in 2.4.10 that would prevent APM on a Dell Latitude C600 (and possibly
others) from entering suspend mode.

A closer investigation revealed that the patch meant to correct a
problem with the internal ps2 pointing device on suspend is at fault.
Commenting out the entry in arch/i386/kernel/dmi_scan.c that triggers
the activation of this logic for the C600 allows the machine to
suspend normally.

Does anybody know the purpose of this change?  It seems to address a
problem I've never seen on my computer...

Please CC relevant replies to my personal address, as I'm not
currently subscribed.


				Tim Stadelmann

