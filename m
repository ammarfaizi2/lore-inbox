Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSGYNHZ>; Thu, 25 Jul 2002 09:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSGYNGV>; Thu, 25 Jul 2002 09:06:21 -0400
Received: from 64-238-252-21.kmcmail.net ([64.238.252.21]:35391 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S313563AbSGYNGS>;
	Thu, 25 Jul 2002 09:06:18 -0400
Subject: insmod error
From: Adam Voigt <adam.voigt@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 25 Jul 2002 09:09:31 -0400
Message-Id: <1027602571.1673.10.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jul 2002 13:09:31.0908 (UTC) FILETIME=[83EEC440:01C233DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to run an "insmod ipt_state.o" to load the IPTABLES State
module and it says:

ipt_state.o: unresolved symbol ip_conntrack_get_Rc5444256
ipt_state.o: unresolved symbol ip_conntrack_module_Rb0361033

IPTables itself works, and is loaded as a module already, and obviously
the Kernel has module support On because iptables works, but for some
reason these won't insert.

I'm running Kernel 2.4.18-5 on Redhat 7.3.

Adam Voigt
adam.voigt@cryptocomm.com

