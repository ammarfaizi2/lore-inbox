Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbTFNFbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbTFNFbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:31:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265622AbTFNFbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:31:32 -0400
Date: Fri, 13 Jun 2003 22:41:22 -0700 (PDT)
Message-Id: <20030613.224122.104034261.davem@redhat.com>
To: ltd@cisco.com
Cc: anton@samba.org, haveblue@us.ibm.com, hdierks@us.ibm.com,
       scott.feldman@intel.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       milliner@us.ibm.com, ricardoz@us.ibm.com, twichell@us.ibm.com,
       netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030614114755.036abbb0@mira-sjcm-3.cisco.com>
References: <20030613.154634.74748085.davem@redhat.com>
	<20030613231836.GD32097@krispykreme>
	<5.1.0.14.2.20030614114755.036abbb0@mira-sjcm-3.cisco.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Lincoln Dale <ltd@cisco.com>
   Date: Sat, 14 Jun 2003 11:52:53 +1000
   
   unless i misunderstand the problem, you can certainly pad the TCP
   options with NOPs ...

You may not mangle packet if it is not your's alone.

And every TCP packet is shared with TCP retransmit
queue and therefore would need to be copied before
being mangled.
