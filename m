Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbTGIJwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTGIJwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:52:33 -0400
Received: from nils.bezeqint.net ([192.115.106.38]:32204 "EHLO
	nils.bezeqint.net") by vger.kernel.org with ESMTP id S265892AbTGIJwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:52:32 -0400
Date: Wed, 9 Jul 2003 13:07:08 +0300
From: gigag@bezeqint.net
Subject: Known problems for 3.5/0.5 virtual space split???
To: linux-kernel@vger.kernel.org
X-Mailer: Webmail Mirapoint Direct 3.3.3-GR
MIME-Version: 1.0
Message-Id: <a4ba947b.a0a80e9b.81ab200@mas3.bezeqint.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if there are any known problems for applying 
2.4.21rc8aa1 patch from Andrea?

I'm trying to boot a Xeon 2.4 box with 4GB of RAM, IDE CD and 
Adaptec AIC7XXX SCSI devices.

I compile the kernel with 1/3 split and it boots OK. When I simply 
change the split to 3.5/0.5, it gets stuck during the boot not being 
able to mount root partition.

Any ideas? Any other working kernel/patch configurations for h/w 
like I have?

Thanks
Giga
