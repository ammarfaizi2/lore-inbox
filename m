Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292345AbSBPKIn>; Sat, 16 Feb 2002 05:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292344AbSBPKIY>; Sat, 16 Feb 2002 05:08:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292345AbSBPKIV>;
	Sat, 16 Feb 2002 05:08:21 -0500
Message-ID: <3C6E2F92.FD196E71@mandrakesoft.com>
Date: Sat, 16 Feb 2002 05:08:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, "David S. Miller" <davem@redhat.com>
Subject: [BK PATCH] Merge e1000 gigabit driver (yay)
Content-Type: multipart/mixed;
 boundary="------------A1A0B0DF54E6FBAE01E6B1DF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A1A0B0DF54E6FBAE01E6B1DF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,

I'm pleased to submit to you a BK merge of Intel's e1000 driver.  The
license is now "GPL or (BSD + patent grant)", which should satisfy those
concerns.

I would also like to publicly thank Intel for this work.  The two
contributors listed have been very responsive to feedback, and they have
put a good deal of work into beating the driver into shape for a kernel
merge.

Now I just hope I can convince them to open up their hardware specs :)

Kind regards,

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
--------------A1A0B0DF54E6FBAE01E6B1DF
Content-Type: text/plain; charset=us-ascii;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"



Pull from:  http://gkernel.bkbits.net/net-drivers-2.5
(BK-only URL)

GNU patch:  ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.5.5/e1000-4.2.4-k1.diff.bz2


---------------------------------------------------------------------------
ChangeSet@1.345, 2002-02-16 04:51:10-05:00, jgarzik@rum.normnet.org
  Merge new gigabit ethernet driver e1000, from Intel.
  
  Contributors: Christopher Leech @ Intel, Scott Feldman @ Intel

 Documentation/networking/e1000.txt |  245 ++++
 MAINTAINERS                        |    7 
 drivers/net/Config.help            |   36 
 drivers/net/Config.in              |    1 
 drivers/net/Makefile               |    5 
 drivers/net/e1000/LICENSE          |   69 +
 drivers/net/e1000/Makefile         |   16 
 drivers/net/e1000/e1000.h          |  233 ++++
 drivers/net/e1000/e1000_ethtool.c  |  377 ++++++
 drivers/net/e1000/e1000_mac.c      | 1821 +++++++++++++++++++++++++++++++++
 drivers/net/e1000/e1000_mac.h      | 1383 +++++++++++++++++++++++++
 drivers/net/e1000/e1000_main.c     | 2036 +++++++++++++++++++++++++++++++++++++
 drivers/net/e1000/e1000_osdep.h    |  142 ++
 drivers/net/e1000/e1000_param.c    |  709 ++++++++++++
 drivers/net/e1000/e1000_phy.c      | 1485 ++++++++++++++++++++++++++
 drivers/net/e1000/e1000_phy.h      |  422 +++++++
 drivers/net/e1000/e1000_proc.c     |  760 +++++++++++++
 17 files changed, 9747 insertions(+)


ChangeSet@1.333, 2002-02-14 03:25:36-05:00, jgarzik@rum.normnet.org
  Add board id to via-rhine net driver, for board added in
  previous revision (thus fixing the build).

 drivers/net/via-rhine.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


ChangeSet@?????, jgarzik@rum.normnet.org
  Update 8139too net driver to new arg-free recalc_sigpending() API
  function

 drivers/net/8139too.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

---------------------------------------------------------------------------

--------------A1A0B0DF54E6FBAE01E6B1DF--

