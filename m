Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVLPPiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVLPPiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLPPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:38:19 -0500
Received: from dsl3-63-249-91-140.cruzio.com ([63.249.91.140]:18333 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1750712AbVLPPiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:38:18 -0500
Date: Fri, 16 Dec 2005 07:38:16 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200512161538.jBGFcGWo026756@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Dec 15, 2005 at 03:42:54PM +0100, Denny Priebe wrote:
>> On Tue, Dec 13, 2005 at 11:38:32AM -0800, Greg KH wrote with possible deletions:
>> 
>> > > These disconnects and reconnects disappear as soon as there's 
>> > > a process reading either /dev/input/mouse0 or /dev/input/event5 
>> > > (mouse0 and event5 according to my setup).
.. 
>> What confuses me a bit is that theses USB disconnects do not appear
>> as soon as I read what the tablet provides.

It's possible that this is a 'feature' of the device firmware. Perhaps the
windows driver continuously reads the device regardless of any user program
activity. When the device notices that it has user input that isn't being read
it disconnects and reconnects to get the OS's attention. So it might be a
workaround for a buggy driver or windows itself?

In a funny way it's kind of cool. I (and I assume everyone else) have had to
unplug and replug USB devices to get them to work on occasion. With this, you
just bang on it enough and it does the unplug/replug itself :-)

Just a wild theory...

