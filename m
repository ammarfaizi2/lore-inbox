Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUBSB5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUBSB5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:57:17 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:49815 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267454AbUBSB4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:56:22 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: struct hdlc_device + embedded struct net_device disassosiation
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 19 Feb 2004 02:33:55 +0100
Message-ID: <m3brnvn98c.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Your 2.6 network patchkits contained patches disassociating struct
net_device from struct hdlc_device in drivers/net/wan/hdlc_*
and in various hw WAN drivers. What is the status of this patch?
Is it still needed and while it was dropped as untested, should I
review/test it? It looks quite complete and reasonable I think.
-- 
Krzysztof Halasa, B*FH
