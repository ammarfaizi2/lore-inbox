Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbTDCOhg>; Thu, 3 Apr 2003 09:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263408AbTDCOhf>; Thu, 3 Apr 2003 09:37:35 -0500
Received: from smtpout.mac.com ([17.250.248.85]:54252 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263407AbTDCOhe>;
	Thu, 3 Apr 2003 09:37:34 -0500
Message-ID: <6811369.1049381341811.JavaMail.leimy2k@mac.com>
Date: Thu, 03 Apr 2003 08:49:01 -0600
From: David Leimbach <leimy2k@mac.com>
To: linux-kernel@vger.kernel.org
Subject: Interesting Logitech Keyboard problem and workaround [hardware based]
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running debian PPC linux on a PowerMac G4 Quicksilver box.

I have a problem involving a Logitech Wireless Elite Duo keyboard mouse 
combo setup.  

Basically the keyboard works fine but the mouse pointer moves only up and
down with any of the PS/2 based protocols in X as well as GPM.  I narrowed
the problem down to the way linux is dealing with the wireless receiver for
both devices.  

I made the problem "go away" by hooking the wireless receiver up to a Belkin
PS/2 -> USB converter box and plugging that into the Mac.  Now both mouse
and keyboard work great under X.  

The only problem is when I boot to Mac OS X now I have to move cables around
to get the proper keymap labelled on the keyboard to work as well as the extra
"multimedia" buttons etc.

Another solution was to ignore the mouse part of the duo and use another older
logitech cordless mouse on a different receiver... This works fine too but I don't
have enough mice to go to all my machines and I don't care for KVM :).

The problem is now for me only a minor annoyance but I am more than willing
to work with anyone who has the time to work this problem out.

I noticed a very recent patch was submitted to this list:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104864596805230&w=2

I hope this involves dealing with this problem.... If not, let me know.  I am available
for testing ideas to figure this one out :)

Thanks guys... Keep up the good work!

Dave Leimbach
