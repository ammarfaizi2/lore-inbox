Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSGTAW1>; Fri, 19 Jul 2002 20:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSGTAW1>; Fri, 19 Jul 2002 20:22:27 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:18186 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S317257AbSGTAW1>; Fri, 19 Jul 2002 20:22:27 -0400
Date: Sat, 20 Jul 2002 01:25:21 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: kbuild - building a module/target from multiple directories
Message-ID: <20020720002521.GA34954@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17Vi3o-0009x7-00*X1VnBJZwz5k* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With kbuild in 2.5, how do I specify that a module/target is to be built of
object files and sub-directories ?

The "obvious" approach :

obj-$(CONFIG_BLAH) := blah.o

blah-objs := blah_init.o blahstuff/

doesn't work. Is there an example of a module doing this ?

findall Makefile | xargs grep '+=' | grep -- -objs | awk -F: '{print $2}' | grep /
isn't promising ...

I'd like to avoid the awkwardness of multiple modules and the
unpleasantness of too many files in a single directory

thanks
john

-- 
"Of all manifestations of power, restraint impresses the most."
	- Thucydides
