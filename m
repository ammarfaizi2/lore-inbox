Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUDFIsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 04:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUDFIsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 04:48:52 -0400
Received: from law10-f82.law10.hotmail.com ([64.4.15.82]:29708 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263664AbUDFIsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 04:48:50 -0400
X-Originating-IP: [64.40.39.168]
X-Originating-Email: [quazgaa@hotmail.com]
From: "Quazgaa Scwhaa" <quazgaa@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Disappearing cursor with vesafb
Date: Tue, 06 Apr 2004 01:48:49 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F82X7oG3AvUzk00032908@hotmail.com>
X-OriginalArrivalTime: 06 Apr 2004 08:48:49.0544 (UTC) FILETIME=[FAE23080:01C41BB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have been living with a randomly (and frequently) disappearing 
cursor (console/vterm) using vesafb for uh well lets see my whole friggin 
life. as long as ive been using vesafb anyway, which is a long time. =(  
Since nobody seems to know or care perhaps this email will at least let 
someone know.  At this very moment I am still running on 2.6.2-rc1 , but 
this disappearing cursor phenomena has been true since 2.4.  I havent run a 
distribution of linux in about 2 years so I forget if this was true (or if i 
was even using vesafb) back when i was running debian. I use the following 
to get a red block cursor:

echo -e '\033[?17;0;64c'

This block cursor does not have the disappearing problem. however, I like 
the more traditional blinking underscore for working in vi and such, so I do

echo -e '\033[?82c'

to get the blinking underscore.  This cursor (on all terminals which i use 
this style of cursor) somewhat randomly disappears with great frequency. 
i.e. there is no visible cursor at all. and again allthewhile my red block 
cursors are unaffected. The following things instigate the disappearance of 
my cursor:  Switching to X and back to console, and any other kind of 
switching to a graphical sort of mode, be it framebuffer apps like graphical 
links, mplayer, etc.  Also the console screen blanking after 10 or however 
many minutes screensaver type of deal.  The thing is that it is somewhat 
random where I can switch to X and back a few times and all is well and then 
the next time the cursor disappears.  Or maybe the first time I switch to X 
and back the cursor will disappear, etc.  On some rarer occasions i think it 
happens even if i do nothing more than switch from a vterm with a blinking 
underscore cursor to one with a red block and then back.

Also note that I have seen this exact same behavior on machines and linux 
systems other than my own, including knoppix.

Also again, I usually just do 'reset' to get my cursors back, though this is 
random as well ie whether it works or not, depending which vterm i do it 
from, etc. For example it works more often if i switch to a vterm that hasnt 
been logged in yet, or if i log out and log back in, then do reset.

If anyone has anything to say about this please CC me (quazgaa@hotmail.com) 
thanks.

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! 
http://join.msn.com/?page=features/mlb&pgmarket=en-us/go/onm00200439ave/direct/01/

