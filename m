Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSBZRNB>; Tue, 26 Feb 2002 12:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBZRMw>; Tue, 26 Feb 2002 12:12:52 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:3295 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S291625AbSBZRMh>; Tue, 26 Feb 2002 12:12:37 -0500
Message-Id: <200202261624.JAA22808@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.5.5-dj1, add 1 help text to net/Config.help
Date: Tue, 26 Feb 2002 10:10:45 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_VLAN_8021Q to net/Config.help.

The text was obtained from 2.4.18, modified by adding <> around the URL.
There was an entry in Eric's Configure.help 2.97, but this version
appears to be more recent.

Steven

--- linux-2.5.5-dj1/net/Config.help.orig        Tue Feb 26 09:30:49 2002
+++ linux-2.5.5-dj1/net/Config.help     Tue Feb 26 09:32:59 2002
@@ -136,6 +136,15 @@

   It is safe to say N here for now.

+CONFIG_VLAN_8021Q
+  Select this and you will be able to create 802.1Q VLAN interfaces on your
+  ethernet interfaces.  802.1Q VLAN supports almost everything a regular
+  ethernet interface does, including firewalling, bridging, and of course
+  IP traffic.  You will need the 'vconfig' tool from the VLAN project in
+  order to effectively use VLANs.  See the VLAN web page for more
+  information:  <http://www.candelatech.com/~greear/vlan.html>.  If unsure,
+  you can safely say 'N'.
+
 CONFIG_IPX
   This is support for the Novell networking protocol, IPX, commonly
   used for local networks of Windows machines.  You need it if you
