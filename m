Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317930AbSFSQjF>; Wed, 19 Jun 2002 12:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSFSQjE>; Wed, 19 Jun 2002 12:39:04 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:5251 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317930AbSFSQjE>; Wed, 19 Jun 2002 12:39:04 -0400
Subject: Re: Incredible weirdness with eepro100?
From: Joshua Newton <jpnewton@speakeasy.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0206191129040.19899-100000@mammut.nsc.liu.se>
References: <Pine.LNX.4.21.0206191129040.19899-100000@mammut.nsc.liu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7-1mdk 
Date: 19 Jun 2002 12:39:03 -0400
Message-Id: <1024504745.4149.12.camel@claymore.corona>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the fix is sadly simple: switching to a spare 3c905C-TX seems to
have eliminated the problem. Copying the contents of claymore:/pack (a
directory with lots of big RPMs and tarballs and other miscellany) to
rapier:/scratch is super-fast and error-free. This directory includes a
few files (such as the Chaos SoundFont) that killed the transfer
yesterday.

Once I receive my new chassis, I'll move rapier's guts to it and start
testing with FreeBSD 4.6 to try to determine whether the problem is
linked to this particular /hardware/ configuration, or if it's something
in the Linux kernel and/or drivers. I'll also swap around network cards
to try and determine if this is some sort of strange interaction between
the 3c59x and e100/eepro100 drivers.

-- 

"However, Science People like to believe in laws, even when such laws
can be circumvented by their own Science. They become most displeased
if you suggest it would be more accurate to speak of the Generally
Good Idea of Gravity or the Three Useful Guidelines of
Thermodynamics."

		-- James Alan Gardner, /Ascending/

