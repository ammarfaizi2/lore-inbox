Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSIZHcj>; Thu, 26 Sep 2002 03:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262225AbSIZHcj>; Thu, 26 Sep 2002 03:32:39 -0400
Received: from math.uci.edu ([128.200.174.70]:21909 "EHLO math.uci.edu")
	by vger.kernel.org with ESMTP id <S262224AbSIZHci>;
	Thu, 26 Sep 2002 03:32:38 -0400
From: Eric Olson <ejolson@math.uci.edu>
Message-Id: <200209260737.AAA15831@math.uci.edu>
Subject: Channel Bonding
To: linux-kernel@vger.kernel.org
Date: Thu, 26 Sep 2002 00:37:54 -0700 (PDT)
Reply-To: ejolson@math.uci.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using channel bonding with Linux kernel 2.4.17.

I recently tried the standard kernel 2.4.19 but 

	ifconfig bond0 ...

hangs.  The bonding module gets loaded.  The message

	bond0 registered without MII link monitoring, in bonding mode.

appears in the system log.  But then ifconfig hangs and kill -9 ...
won't kill it.  Furthermore running ifconfig again locks the entire
system up.

Configuration is the same as for my working 2.4.17 kernel.

This appears to be a bug to me.  Is anyone using bonding with 2.4.19?
Is this a known issue with 2.4.19? 

Is there something that needs to be done differently with 2.4.19 than
with 2.4.17?

Please copy me directly on replies to this message.

Thanks, Eric Olson
