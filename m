Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSI2BjZ>; Sat, 28 Sep 2002 21:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbSI2BjZ>; Sat, 28 Sep 2002 21:39:25 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:19218 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261512AbSI2BjY>; Sat, 28 Sep 2002 21:39:24 -0400
Date: Sun, 29 Sep 2002 02:44:40 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, akpm@digeo.com, Philippe Elie <phil.el@wanadoo.fr>
Subject: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929014440.GA66796@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vT8S-0001yY-00*aq.88HcAUL6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a new version of oprofile against 2.5.39. Thanks Andi,
Christoph, and Alan for your comments. I think I should have fixed
the things you mentioned.

As before, the full patch is available here :

http://oprofile.sf.net/oprofile-2.5/oprofile-2.5-all.diff [100k]

with usage notes :

http://oprofile.sf.net/oprofile-2.5.html

and more readable broken-out patches (but not applyable) :

http://oprofile.sf.net/oprofile-2.5/

Changes from last time :

o More comments on the fiddly bits
o Fix for NMI on shutdown
o Added stats
o avoid some mis-attributed samples
o Re-worked FS stuff
o Moved x86 stuff into arch/
o Fixed UP build
o various fixes and cleanups

regards
john
