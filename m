Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTJMGgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 02:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTJMGgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 02:36:36 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:53702
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261492AbTJMGgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 02:36:35 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - stability freeze
Date: Sun, 12 Oct 2003 23:52:39 -0500
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310122352.40019.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It locked my laptop solid after about half an hour answering email with X11 up 
(possibly a panic, but the LEDs weren't flashing.  Nothing in the log between 
the last dhcp lease renewal a few minutes earlier and the start of the next 
cold boot...)

Reverted to test 6 until I feel brave again.  (I've gone back to grad school 
and have homework due monday.)  2.6.0-test6 sometimes boots up with a dead 
keyboard, but has yet to spontaneously hang on me after bootup...

No clue how to debug this one.  It died while I was typing an email (between 
one keystroke and the next, my screen was suddenly a bitmap.  No mouse 
movement, the little CPU use indicator stopped fluctuating (at zero), etc).

I had an rsync going in the background through a dhcp wireless connection 
(backing up my /home partition to a remote machine), KDE up with kmail 
sending and receiving email, and a couple of web browser windows minimized 
that may have been doing page refreshes...  But otherwise, nothing special.  
(Running off of battery with a little under half of it left...)

Rob


