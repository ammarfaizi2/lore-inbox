Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTGFL0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 07:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTGFL0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 07:26:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62370
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262013AbTGFL02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 07:26:28 -0400
Subject: Re: 2.4.21 ServerWorks DMA Bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706111015.GA303@louise.pinerecords.com>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
	 <87fzllh21i.fsf@gitteundmarkus.de>
	 <Pine.LNX.4.53.0307050956060.2029@mackman.net>
	 <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030706090656.GA4739@louise.pinerecords.com>
	 <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk>
	 <20030706111015.GA303@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057491491.1032.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 12:38:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 12:10, Tomas Szepe wrote:
> Also note that when the '-X' switch is omitted (i.e. one only issues
> "/usr/sbin/hdparm -d1 /dev/hdX"), the driver sets up a mode that doesn't
> work and then quickly falls back to PIO.

Your BIOS has not tuned the drive for DMA either.

