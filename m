Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276024AbTHONEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276027AbTHONEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:04:44 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:45994 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S276024AbTHONEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:04:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16188.55901.775494.576967@gargle.gargle.HOWL>
Date: Fri, 15 Aug 2003 15:04:29 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "Russell King" <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Trying to run 2.6.0-test3
In-Reply-To: <0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
	<20030815111442.A12422@flint.arm.linux.org.uk>
	<0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond writes:
 > Now the question is why cardmgr doesn't start automatically in 2.6.0-test3.

You probably need fixes to /etc/rc.d/init.d/pcmcia (drop module ".o"
extensions from modprobe commands) and /etc/hotplug/net.agent (case
$ACTION needs "add|register" not just "register").

/Mikael
