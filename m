Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSJQQVH>; Thu, 17 Oct 2002 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJQQVG>; Thu, 17 Oct 2002 12:21:06 -0400
Received: from tml.hut.fi ([130.233.44.1]:5129 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S261542AbSJQQVF>;
	Thu, 17 Oct 2002 12:21:05 -0400
Date: Thu, 17 Oct 2002 19:26:25 +0300
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Cc: yoshfuji@wide.ad.jp, pekkas@netcore.fi, torvalds@transmeta.com,
       jagana@us.ibm.com
Subject: [PATCHSET] Mobile IPv6 for 2.5.43
Message-ID: <20021017162624.GC16370@morphine.tml.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey, Dave, everyone,

We are resending our code for kernel inclusion consideration.  I hope
with this submission we have addressed all the concerns raised on the
list (i.e. draft revision) as well as offline (splitting the patch to
smaller chunks).

To Pekka and Hideaki,

Intermediate revision of the specification "Draft 18++" appeared a few
days ago, which addressed most of the issues with earlier drafts (16,
17, 18).  This made it possible to update our code to something usable
(later than 15).  This patch set has support for most of it.

To Alexey, (and everyone else)

The patch has been split for easier reading as follows:

ipv6_tunnel.patch	6over6 tunneling
network_mods.patch	Modifications to network code and hooks
mipv6_cn_support.patch	Correspondent node support (+common code)
mipv6_mn_support.patch	Mobile node support (+common code with HA)
mipv6_ha_support.patch	Home agent support

The patches are incremental, so they must be applied in this order.
Patches are not included in this mail, but you can find them at:

http://www.mipl.mediapoli.com/patches/ipv6_tunnel.patch
http://www.mipl.mediapoli.com/patches/network_mods.patch
http://www.mipl.mediapoli.com/patches/mipv6_cn_support.patch
http://www.mipl.mediapoli.com/patches/mipv6_mn_support.patch
http://www.mipl.mediapoli.com/patches/mipv6_ha_support.patch

Userspace tools are available at:
http://www.mipl.mediapoli.com/download/mipv6-tools/

Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

