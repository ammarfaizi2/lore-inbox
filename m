Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312059AbSCTT0w>; Wed, 20 Mar 2002 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312065AbSCTT0m>; Wed, 20 Mar 2002 14:26:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25874 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312071AbSCTT03>;
	Wed, 20 Mar 2002 14:26:29 -0500
Message-ID: <3C98E234.4020009@mandrakesoft.com>
Date: Wed, 20 Mar 2002 14:25:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Linux kernel misc-2.5.7-jg1
Content-Type: multipart/mixed;
 boundary="------------060707020606060701060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707020606060701060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.5.7/misc-2.5.7-1.patch.bz2

Changeset and pull info follows.


--------------060707020606060701060906
Content-Type: text/plain;
 name="misc-2.5.7-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.7-1.txt"

Linus and other BK users, please do a

	bk pull http://gkernel.bkbits.net/misc-2.5

This will update the following files:

 Documentation/BK-usage/bksend           |   36 ++++++
 Documentation/BK-usage/bz64wrap         |   41 +++++++
 Documentation/BK-usage/cset-to-linus    |    2 
 Documentation/BK-usage/csets-to-patches |    2 
 Documentation/BK-usage/unbz64wrap       |   25 ++++
 Documentation/DocBook/Makefile          |    8 -
 Documentation/DocBook/via-audio.tmpl    |    4 
 drivers/char/rocket.c                   |  176 --------------------------------
 drivers/net/wan/comx-hw-munich.c        |   32 +----
 sound/oss/ac97_codec.c                  |    2 
 10 files changed, 126 insertions(+), 202 deletions(-)

through these ChangeSets:

<wstinson@infonie.fr> (02/03/20 1.543)
   Fix DocBook documentation for ALSA merge,
   basically s#drivers/sound#sound/oss#

<silicon@falcon.sch.bme.hu> (02/03/20 1.542)
   Update munish WAN driver to not kfree memory multiple times.

<jgarzik@mandrakesoft.com> (02/03/20 1.541)
   Add two AC97 codec ids to old OSS ac97_codec driver.
   
   Contributed by Peter Christy.

<jgarzik@mandrakesoft.com> (02/03/20 1.540)
   Update rocketport serial driver:
   * remove linux 2.1.x backwards compat code (William Stinson)
   * remove ENABLE_PCI define, use CONFIG_PCI instead
   * no need to enclose MODULE_xxx in ifdef MODULE

<tvignaud@mandrakesoft.com> (02/03/20 1.539)
   Remove silly overdependency on Perl 5.6.1 in BK helper scripts.

<adilger@clusterfs.com> (02/03/20 1.538)
   Add three scripts for BK users, to Documentation/BK-usage:
   bzsend: good for users who want to send reviewable BK patches
   bz64wrap, unbz64wrap: bzip2 uuencoding wrappers for encapulating BK patches


--------------060707020606060701060906--

