Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUHUI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUHUI27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268898AbUHUI26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:28:58 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:32010 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268902AbUHUI24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:28:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Josan Kadett" <corporate@superonline.com>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:27:45 +0300
X-Mailer: KMail [version 1.4]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408211127.45076.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 12:18, Josan Kadett wrote:
> That is not much of an intelligible idea. A way to hack the kernel could be
> found as I still presume. "Turn off checksums" but not by re-writing the
> whole tcp code in the kernel. Isn't that possible ? Linux is an operating
> system of infinite possibilities, right ? But only if you know how to hack
> it...

Of course you can hack the kernel to do it.

However, by replacing that box with Linux device you
get one more Linux box and you will be capable of
doing whole slew of useful things, like traffic filtering, shaping,
accounting, Ethernet bridging, etc etc etc, if/when you will need it.
You can easily debug problems with tools like tcpdump and ethereal.
I simply cannot list everything Linux can do, I don't plan to write
a novel here ;]

I bet current 'crazy box' has nothing even vaguely resembling
these capabilities. Heck, it cannot do standard TCP properly.
So there is little reason to waste your time trying to work around it.
-- 
vda
