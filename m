Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSGNVFq>; Sun, 14 Jul 2002 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSGNVFp>; Sun, 14 Jul 2002 17:05:45 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:31174 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317302AbSGNVFo>; Sun, 14 Jul 2002 17:05:44 -0400
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<1026683982.13885.85.camel@irongate.swansea.linux.org.uk>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Jul 2002 17:07:50 -0400
In-Reply-To: <1026683982.13885.85.camel@irongate.swansea.linux.org.uk>
Message-ID: <xltbs9aj9w9.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> Intriguing. Something horrible is happening on your system to see 98%
> system time off a bus mastering DMA controller. It should only look like
> that on things like an AHA152x 

Well, to be frank, I wouldn't blame the scsi subsystem: the disk is almost
idle and procinfo -d gives an average of 6 irqs (using the default 5 sec
delay between 2 updates)...
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
