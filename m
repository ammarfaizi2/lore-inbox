Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTLELw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTLELw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:52:27 -0500
Received: from relay-2m.club-internet.fr ([194.158.104.41]:12160 "EHLO
	relay-2m.club-internet.fr") by vger.kernel.org with ESMTP
	id S263923AbTLELwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:52:25 -0500
Date: Fri, 5 Dec 2003 12:52:23 +0100
From: Loic Bernable <leto@vilya.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t11: keyboard problems revisited
Message-ID: <20031205115223.GA11214@thorgal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-GnuPG-Fingerprint: 5BF7 988C 9367 2E86 DE52  F141 5F5F 34EE A0BB 3DEB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In his previous email, Jurgen Kramer explained :
> While booting 2.6.0-t11 into textmode I found out there are still some
> problems with the keyboard code.
> 
> On my PC with USB keyboard (Logitech iTouch) I can't use the "\" key
> properly so I can't type "ps -ef | grep blabla" which is not very
> helpful is you want to try to investigate problems.
>
> So there seems to be some kind of anti-pipe conspiracy here...;-)

This problem is not specifically related to the Logitech one. There are
several cases related to this bug (ie for instance
http://lkml.org/lkml/2003/11/27/153 )

Your | key should be the same as the "*" key on french keyboards.

I submitted a bug report dealing with the details of this problem, but
still no answer yet.

http://bugzilla.kernel.org/show_bug.cgi?id=1637


The patch provided by Tonnerre Anklin should work (I wouldn't have
changed the two values, just 84 -> 43) but it may break some other 
keyboards. This is one question asked in the bug report.


And the other is : why did it work with 2.4.x kernels ?


Thank you to Cc me for any answer ...

-- 
### Loïc Bernable aka Leto -- leto(à)vilya,org -- Parinux, April, LinuxFR ###
c:\> uptime
5:11pm  up 0 days, 0:15, 1 user (obviously), load average: 4.98, 5.03, 5.01
