Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTEPSfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTEPSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:35:20 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:5591 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264537AbTEPSfS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:35:18 -0400
Date: Fri, 16 May 2003 20:48:10 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: ide-floppy and 2.5 works great...
Message-ID: <20030516184810.GA26628@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hadded lots of trouble with my ide ZIP 250...
I was using ide-scsi under pre 2.4.21-rc1-ac3, but since 2.4.21-rc1-ac3
the ide-scsi wasn't working for my ZIP, so I tried ide-floppy, and it
was the beginning of the same problem as under the 2.5 kernels...

It seems to me the problem was that I use the "raw Zip" without
partition, which didn't trouble ide-scsi, but with ide-floppy...

I have made a primary partition, and now it seems to works perfectly
well with XFS on it ;-)

Is it really needed to have a partition table on a ZIP?

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
