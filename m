Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVAMQPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVAMQPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVAMQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:08:38 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:45923 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S261669AbVAMQAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:00:21 -0500
Date: Thu, 13 Jan 2005 09:59:52 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <41E68215.8060004@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, magnus.damm@gmail.com
Message-id: <41E69AF8.1000804@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44248.2000500@softplc.com>
 <Pine.LNX.4.58.0501111322060.2373@ppc970.osdl.org> <41E68215.8060004@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info comes.  The embedded system has a single PCI slot.  So I tried 
the PCI card with the RICOH CARDBUS support on it in the embedded 
system, and plugged in the problem CARDBUS card into the RICOH board 
before powering up.  This is analogous to the case before, when the 
motherboard resident TI1520 chip was in play. 

Now the system can load yenta_socket fine.

So it is definitely not a power supply _capacity_ issue, although I 
suppose it could be power availability timing issue.  This experiment 
tends to put more doubt into the TI1520 chip and the yenta support for it.

Dick

