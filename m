Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbTLIIlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbTLIIlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:41:32 -0500
Received: from ns1.netnea.com ([138.189.116.70]:11200 "EHLO james.netnea.com")
	by vger.kernel.org with ESMTP id S266144AbTLIIjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:39:24 -0500
Subject: Re: 2.6 Test 11 Freeze on USB Disconnect
From: Charles Bueche <charles@bueche.ch>
To: "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
Content-Type: text/plain
Message-Id: <1070957926.6531.10.camel@bluez.bueche.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 09:18:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

similar problem on my Dell I8600 with integrated bluetooth. It happens
at "/etc/init.d/hotplug stop". I think (but am not sure, I would have to
test) that it happens only if hciconfig is up. I haven't created proper
stop scripts so far...

My guess is that some bluez module unload failure cause the oops.

The switch on my I8600 is a hotkey (<ALT><F2>).

Charles

On Sun, 2003-12-07 at 20:35, Jonathan A. Zdziarski wrote:
> Greetings,
> 
> I recently upgraded from 2.4.20-24 to 2.6 Test 11 using a Redhat
> distribution.  Got everything up and running great, except the entire
> system appears to freeze (requiring a hardware reset) when I disconnect
> my bluetooth device.
> 
> I am using a Thinkpad T30, which has an integrated USB-based Bluetooth
> card with a little power switch to activate/deactivate it.  I can turn
> it on and it'll work fine, see devices, etc., but every single time I
> turn it off, the laptop freezes.  Did not happen with the 2.4 kernel.
> 
> I am using the bluetooth stack provided by the Kernel along with the
> configure scripts and such from the Bluez package.  It does not appear
> to be a "bluetooth" issue, however - it seems more related to USB to me.
> 
> Anyhow I thought I'd fire off an email.  I'd be glad to supply more
> specific information - just tell me what you need.  I am able to
> reproduce this every time so shouldn't have a problem determining what
> might affect the situation in a positive way.
> 
> Compressed copy of my .config included
> 
> 
> Jonathan
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer

