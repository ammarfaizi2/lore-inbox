Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVAPM0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVAPM0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVAPM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:26:54 -0500
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:25231
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S262494AbVAPM0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:26:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16874.23937.91624.469146@ccs.covici.com>
Date: Sun, 16 Jan 2005 07:26:41 -0500
From: John covici <covici@ccs.covici.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
In-Reply-To: <9e473391050116033435e5db9c@mail.gmail.com>
References: <41E64DAB.1010808@hist.no>
	<16870.21720.866418.326325@ccs.covici.com>
	<21d7e997050113130659da39c9@mail.gmail.com>
	<20050115185712.GA17372@hh.idb.hist.no>
	<21d7e997050116020859687c4a@mail.gmail.com>
	<20050116105011.GA5882@hh.idb.hist.no>
	<9e4733910501160304642f7882@mail.gmail.com>
	<21d7e99705011603072d26727a@mail.gmail.com>
	<9e473391050116033435e5db9c@mail.gmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I don't have a module called drm except a .a file in the library
directory for X -- I have some radeon stuff but modprobe radeon
debug=1 says invalid parameter and loads the module.  Am I missing
something?

Thanks.

on Sunday 01/16/2005 Jon Smirl(jonsmirl@gmail.com) wrote
 > On Sun, 16 Jan 2005 22:07:13 +1100, Dave Airlie <airlied@gmail.com> wrote:
 > > > you need to check the output from "modprobe drm debug=1" "modprobe
 > > > radeon" and see if drm is misidentifying the board as AGP. We don't
 > > > want to fix something if it isn't broken.
 > > 
 > > 
 > > have a look at bug 255 in fd.o bugzilla, this was what was wrong with
 > > the original code, I'd seriously think about putting this code into
 > > the radeon drm not the old stuff..
 > > 
 > > Dave.
 > > 
 > 
 > I'm fine with adding this code, but we still don't know if this is the
 > cause of his problem. The debug output can determine if this really is
 > the source of the problem or if it is somewhere else.
 > 
 > 
 > -- 
 > Jon Smirl
 > jonsmirl@gmail.com
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/

-- 
         John Covici
         covici@ccs.covici.com
