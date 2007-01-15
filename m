Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbXAOVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXAOVCi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbXAOVCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:02:37 -0500
Received: from websiteout12.httpserveur.net ([67.15.80.77]:35639 "HELO
	websiteout12.httpserveur.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750728AbXAOVCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:02:37 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 16:02:36 EST
X-Abuse: Please report all abuse immediately to abuse@httpserveur.net
Subject: REAL-TIME GRAPHICAL BANDWIDTH/CPU/RAM MONITOR FOR LINUX
From: Vincent Perrier <clowncoder@clowncode.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 15 Jan 2007 21:55:43 +0100
Message-Id: <1168894543.6007.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,
 I have just finished coding a REAL-TIME GRAPHICAL MONITOR for linux.

 The most difficult function of the kernel-embedded spy has been the
 catching of the uid and the  name of a process for a spyed-upon
 connection (udp or tcp). I had some nasty freezes before my last resort
 solution which is not completely satisfying (I now use local_save_flags
 very punctually).

 For the real hackers who would help to resolve this issue, have a look
 in the klownspy directory, monitor.c, try_to_get_to_the_socket_owner
 function, this function is called from bottom half (or softirq?)
 through a subscription to all packets with dev_add_pack.

 Another thing: BionicClown007 brings back amongs other things the
 memory used in the system, at a point in the computation, we need
 total_swapcache_pages (= swapper_space.nrpages) and this symbol is
 not exported (see collect.c).
 Is there an other way to get the used memory info?

 The BionicClown007 is at http://clowncode.net,
 BionicClown007 is the total rewriting of the ClownToolKit.

 Regards to all
 Vincent Perrier


