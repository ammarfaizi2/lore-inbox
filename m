Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284445AbRLXGWE>; Mon, 24 Dec 2001 01:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLXGVz>; Mon, 24 Dec 2001 01:21:55 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:49820 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S284445AbRLXGVr>;
	Mon, 24 Dec 2001 01:21:47 -0500
Message-ID: <3C26C978.7030801@candelatech.com>
Date: Sun, 23 Dec 2001 23:21:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: [PATCH]:   vlan config help
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should make VLAN configuration slightly more clear...

diff -u -r -N -X /home/greear/exclude.list linux/Documentation/Configure.help linux.dev/Documentation/Configure.help
--- linux/Documentation/Configure.help	Fri Dec 21 10:41:53 2001
+++ linux.dev/Documentation/Configure.help	Fri Dec 21 20:47:52 2001
@@ -24237,6 +24237,16 @@
    would like kernel messages to be formatted into GDB $O packets so
    that GDB prints them as program output, say 'Y'.

+802.1Q VLAN Support
+CONFIG_VLAN_8021Q
+  Select this and you will be able to create 802.1Q VLAN interfaces on your
+  ethernet interfaces.  802.1Q VLAN supports almost everything a regular
+  ethernet interface does, including firewalling, bridging, and of course
+  IP traffic.  You will need the 'vconfig' tool from the VLAN project in
+  order to effectively use VLANs.  See the VLAN web page for more
+  information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
+  you can safely say 'N'.
+
  #
  # A couple of things I keep forgetting:
  #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


