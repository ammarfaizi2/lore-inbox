Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLYDAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 22:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLYDAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 22:00:53 -0500
Received: from smtp06.ya.com ([62.151.11.163]:8414 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S264271AbTLYDAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 22:00:52 -0500
Message-ID: <3FEA7399.5040108@wanadoo.es>
Date: Thu, 25 Dec 2003 06:20:25 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: IDE performance drop between 2.4.23 and 2.6.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot compare 2.4 with 2.6, but I think this is not too much...

It's a nforce2 motherboard, paralel-ATA and Seagate Barracuda IV (or V, 
I cannot remember). AthlonXP-2500+.

Any of the IDE gurus can say something about this?

Thanks!!


/dev/hda:
 Timing buffer-cache reads:   1740 MB in  2.00 seconds = 868.83 MB/sec
 Timing buffered disk reads:   94 MB in  3.03 seconds =  31.03 MB/sec


bash-2.05b# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 156301488, start = 0
