Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271224AbTHCSEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271223AbTHCSEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:04:53 -0400
Received: from pro5.mtco.com ([207.179.200.251]:3745 "HELO pro5.mtco.com")
	by vger.kernel.org with SMTP id S270848AbTHCSEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:04:52 -0400
From: Tom Felker <tcfelker@mtco.com>
To: linux-kernel@vger.kernel.org
Subject: Fast DMA CD audio extraction
Date: Sun, 3 Aug 2003 12:59:29 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308031259.29704.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get decent performance (e.g. DMA, not PIO) extracting audio with 
cdparanoia from an new IDE CD-ROM.  The current problem is very slow ripping 
and very high system CPU time.  hdparm reports DMA is on, and reading data is 
perfectly fast.

What kernel versions and patches should I be trying?

(Please cc: me, emailing in reply to linux.kernel posts munges threading)
Thanks,

-- 
Tom Felker

If nature has made any one thing less susceptible than all others of exclusive 
property, it is the action of the thinking power called an idea.

