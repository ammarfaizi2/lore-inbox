Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTIWSwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIWSwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:52:07 -0400
Received: from [69.26.131.105] ([69.26.131.105]:26540 "EHLO jaz.jportfolio.com")
	by vger.kernel.org with ESMTP id S262798AbTIWSvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:51:12 -0400
Message-ID: <3F709609.9000206@ofbiz.org>
Date: Tue, 23 Sep 2003 14:50:49 -0400
From: Andy Zeneski <jaz@ofbiz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mouse (PS/2) Problem 2.6.0-test5-bk9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post to the kernel lists, so please excuse me if I'm 
not totally informed.

I have searched the archives for this, but didn't have much luck. So, 
please bare with me.

I have just installed the 2.6.0-test5 kernel moving from 2.4.20/22. I 
like most of the enhancements, but have a problem with one.

I have an IBM Thinkpad T30 with both Trackpoint and TouchPad. I disable 
the touchpad in bios, and only use the trackpoint. I compiled in PS/2 
support with out the Synaptics support. The mouse works fine, it 
actually works too good.

In the 2.4 kernel, the middle button (when configured in X) would allow 
me to use the eraser head and scroll, like a wheel mouse. Now, in the 
2.6 kernel I still have this ability, but the added ability of using 
this button as an actual middle mouse button. Which can be considered a 
great enhancement.

However, as soon as you start dragging items around your desktop when 
only trying to scroll, and random blocks of text gets pasted while 
scrolling, this becomes a bit annoying.

Are there any patches, which either disable the middle button support 
(as it was in 2.4) or instead of activating on press, activate on 
release for paste (maybe time the length of the press and if it was 
pressed then released, paste if held for x milliseconds don't paste). 
I'd have to figure out something with the dragging, but that may be 
something I can configure in X.

Please, any suggestions? I love this new kernel and hate the idea of 
having to go back when my only major problem is a middle mouse button. :)

Thanks for everything!
-Andy

