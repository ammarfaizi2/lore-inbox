Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbTKSM1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 07:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTKSM1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 07:27:11 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:36784 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S264017AbTKSM1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 07:27:10 -0500
From: Danilo Raineri <danirain@tin.it>
Reply-To: danirain@tin.it
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 and joypad responsiveness
Date: Wed, 19 Nov 2003 13:27:07 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311191327.07993.danirain@tin.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use 2.6.0-test9 (preemptive) and an 8-button analog joypad plugged in my
SBLive gameport, so I load the following modules:
 
analog
emu10k1_gp
joydev
gameport
 
Joypad response in xmame and other apps (even jscal) seems a lot worse than
in 2.4 kernels; even with a low system load, a lot of inputs "get lost", in
the sense that I have to repeat the command two or three times before
actually seeing it accepted.
 
The same does not happen using a usb Sidewinder, and the appropriate
modules.


-- 
Danilo Raineri, danirain@tin.it


