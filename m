Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbTFQQAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFQQAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:00:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52950 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264826AbTFQQAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:00:06 -0400
Date: Tue, 17 Jun 2003 09:09:30 -0700 (PDT)
Message-Id: <20030617.090930.102574393.davem@redhat.com>
To: shemminger@osdl.org
Cc: Valdis.Kletnieks@vt.edu, girouard@us.ibm.com, stekloff@us.ibm.com,
       janiceg@us.ibm.com, jgarzik@pobox.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030617090859.0ffa0ca8.shemminger@osdl.org>
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>
	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>
	<20030617090859.0ffa0ca8.shemminger@osdl.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: Tue, 17 Jun 2003 09:08:59 -0700

   Read the hotplug thread to see how Linus
   said, he will never add a binary event daemon interface.

Funny, rtnetlink is exactly this and it is in the tree :-)

Every networking configuration event is transmitted over
rtnetlink sockets to all listeners, in a fixed binary
format.

What Linus doesn't want is this for configuration events,
ie. things like "device appears" not "my ethernet burped"
