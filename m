Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbSJHAj5>; Mon, 7 Oct 2002 20:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262932AbSJHAj5>; Mon, 7 Oct 2002 20:39:57 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:62727 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262774AbSJHAj4>; Mon, 7 Oct 2002 20:39:56 -0400
Date: Tue, 8 Oct 2002 01:45:33 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: oprofile-list@lists.sf.net, akpm@digeo.com, torvalds@transmeta.com
Subject: [PATCH] oprofile for 2.5.41
Message-ID: <20021008004533.GA37613@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please see

http://oprofile.sourceforge.net/oprofile-2.5.html

for the necessary user-space tools, and the latest patch.

Note the change to fs/locks.c is necessary, otherwise you will end up
dropping almost all samples on the floor. A proper patch hasn't yet made
its way Linuswards...

This seems to work for me now. In the absence of any necessary major
changes, I intend to split it up into readable chunks and feed it to
Linus fairly soon.

regards
john

-- 
"I will eat a rubber tire to the music of The Flight of the Bumblebee"
