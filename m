Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264819AbRFTDCS>; Tue, 19 Jun 2001 23:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbRFTDCI>; Tue, 19 Jun 2001 23:02:08 -0400
Received: from member.michigannet.com ([207.158.188.18]:46349 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S264819AbRFTDBu>; Tue, 19 Jun 2001 23:01:50 -0400
Date: Tue, 19 Jun 2001 23:01:25 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Repeatable hard locks on console switch. XFree 4.1.0
Message-ID: <20010619230125.D268@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Dear All;

	I can fire up XFree4.1.0 on one or several virtual
consoles, and switch between them, and text consoles to my hearts
content. However, if the X server exits everything is still fine,
_except_ any attempt to switch consoles at this point will lock
up the machine completely. (eg. numlock doesnt work, nor does
magic sysrq, unpingable, no logs)
	[ Trivially the problem manifests itself when one logs in
via xdm, then logs out. You can log back on just fine, but if you
try to switch virtual consoles after this it locks.]
	XFree3.3.6 works good for me. XFree4.1.0 manifests the
problem on 2.4.5, and 2.2.18. I128 server.
	Any comments or suggestions welcome....

Thanks;
Paul
set@pobox.com
