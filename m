Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRIYSqs>; Tue, 25 Sep 2001 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272345AbRIYSqi>; Tue, 25 Sep 2001 14:46:38 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:4298 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S272244AbRIYSqf>; Tue, 25 Sep 2001 14:46:35 -0400
Message-ID: <3BB0D0F3.3090005@korseby.net>
Date: Tue, 25 Sep 2001 20:46:11 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Burning a CD image slow down my connection
In-Reply-To: <1001401550.1017.4.camel@piccoli> <20010925183403.A324@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:

> Aren't you connected over a serial port (modem)? I have the same problem,
> but not when burning an image, but when dumping long cunks of data from CD
> (for example, when studying a content of audio CD). I just see a big packet
> loss.


That's definitely DMA related. I have an old cdwriter that don't understands it 
and so the whole bus is extremely busy during writing. Even my harddisk is very 
slow as well as modem and other things. PCI and ISA cards seem not related. 
(Send packets over tr0 && eth0 without any loss.)

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

