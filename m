Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSE3Itc>; Thu, 30 May 2002 04:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSE3Itb>; Thu, 30 May 2002 04:49:31 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18927 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316499AbSE3Ita>; Thu, 30 May 2002 04:49:30 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1022698033.12888.279.camel@irongate.swansea.linux.org.uk> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Gerald Champagne <gerald@io.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 May 2002 09:48:56 +0100
Message-ID: <12607.1022748536@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the subject of blacklists -- when downgrading the speed of a drive 
because it's found a blacklist, or indeed for any other reason, please 
_print_ the reason for doing so. 

I have drives which work fine at UDMA66, but which some kernels randomly 
refuse to configure above UDMA33 without telling me why. 

Basically, any time you run a drive at a transfer speed lower than the 
minimum of the drive's and host's listed capabilities, you should say why 
you're doing so. 

--
dwmw2


