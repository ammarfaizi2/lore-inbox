Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTKQDmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 22:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTKQDmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 22:42:10 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:28067 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S263325AbTKQDmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 22:42:08 -0500
Subject: Bad interactivity with 2.6-test9
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1069040526.23511.40.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 16 Nov 2003 22:42:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I have been testing 2.6-test9 (Arjan van de Ven's 2.6.0-0.test9.1.67
RPMS rebuilt) tainted by nvidia drivers.

The kernel has worked awesome and desktop interactivity works great
under most circumstances, however I have noticed something ratehr
annoying.

When I start watching a video under mplayer and have something like
spamassassin doing a sa-learn in an x-term if I start the sa-learn
before mplayer and then play a video, the sa-learn makes  no  progress
until I switch away from mplayer (playing full screen).  After which
sa-learn continues to filter through messages much faster, and even
while mplayer is going is still progressing much faster than before I
switched away from mplayer the first time.

Very odd.  Con anyone ideas?

-sb

