Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTE0Wju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTE0Wju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:39:50 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:2434 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S264325AbTE0Wjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:39:49 -0400
Message-ID: <3ED3ECC4.4040407@winischhofer.net>
Date: Wed, 28 May 2003 00:55:00 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
References: <3ED21CE3.9060400@winischhofer.net>  <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>  <3ED32BA4.4040707@winischhofer.net>  <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com> <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk> <3ED3CDA9.5090605@winischhofer.net> <Pine.LNX.4.55.0305271519210.1362@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> It does not look right to me either to poke the IDE controller. Another
> solution might be to parse the routing table and gather informations from
> there. Example, the findings of 0x61,...,0x63 will tell us that we're
> dealing with newer chipsets that uses those for values for the 3 OHCI and
> the EHCI. 

(The "plain" 650 [with 961] has no EHCI; this was introduced with the 962)

 > The revision ID trick seems not effective, at least looking at
> your machine with rev-id 0 that has 0x61..63. Martin, was the revision id
> 0, that you suggested to be handled with the old router, minded ?

What about gathering all that info from the routing table? Please excuse 
this perhaps naive assumption, but isn't that what's it's good for?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net
mailto:twini@xfree86.org

