Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUCWBCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 20:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUCWBCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 20:02:39 -0500
Received: from starsky.ncc.ITgate.net ([213.254.7.2]:13039 "EHLO
	starsky.ncc.itgate.net") by vger.kernel.org with ESMTP
	id S261760AbUCWBCi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 20:02:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
Subject: Kernel 2.4.25 + VLAN + CBQ disc broken ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 23 Mar 2004 02:02:36 +0100
Message-ID: <4008E74134355D43998FFFC3D637BB030463DF@starsky.ncc.itgate.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.4.25 + VLAN + CBQ disc broken ?
Thread-Index: AcQQcofhLtPAk/9jSNOWOzV1ZAlIng==
From: "Gianfranco Delli Carri" <gf.dellicarri@ncc.itgate.net>
To: <linux-kernel@vger.kernel.org>
Cc: <netdev@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetigs,

seems that in a 2.4.25 kernel, with VLAN configured, if you try tu use CBQ disc on VLAN subIf no more traffic can be passed. (NO ARP, NO IP)

Just after: 
/sbin/tc qdisc add dev eth1.10 root handle 1 cbq bandwidth 100Mbit avpkt 1000 cell 8

traffic was dropped.

Seems that in the same server enviroment the CBQ disc attached to the untagged interface can work without problems.

Thanks in advance for your help.

Regards,

Gianfranco


