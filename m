Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSIEFNU>; Thu, 5 Sep 2002 01:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSIEFNU>; Thu, 5 Sep 2002 01:13:20 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:496 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316883AbSIEFNT>; Thu, 5 Sep 2002 01:13:19 -0400
Date: Thu, 5 Sep 2002 01:17:55 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libaio 0.3.90 -- test release for sync up
Message-ID: <20020905011755.A7979@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Well, Andrea seems to be trying to fork libaio, but he never sent 
any patches to me, so I don't know what his complaint with me as 
maintainer is.  I hope he finds it in his heart to submit *patches* 
for any changes he's making.  Anyways, here's a test release going 
in the direction I've meant to for libaio-0.4.0 -- 0.3.15 is a 
compatible release for folks running Red Hat Advanced Server and 
does not break source/binary compatibility.  0.4.0 on the other 
hand breaks source compatibility to match the changes made for 2.5, 
but should still provide backwards compatible symbols.  I've also 
tossed the beginnings of man pages in man/ for people to hack on 
(Alan, Bert you guys need to synch up with each other on list).  
ChangeLog bits are below, the test cases have not been updated for 
the new API, nor has it been tested in any way mean or form.  I'll 
try to get a 0.3.91 out before I leave tomorrow afternoon, but if 
not it will wait until Tuesday.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

0.4.0
        - remove libredhat-kernel
        - add rough outline for man pages
        - make the compiled io_getevents() add the extra parameter and 
          pass the timeout for updating as per 2.5

0.3.15
        - use real syscall interface, but don't break source compatibility 
          yet (that will happen with 0.4.0)

