Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTGGVat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTGGVat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:30:49 -0400
Received: from vsmtp3.tin.it ([212.216.176.223]:61572 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S264825AbTGGVar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:30:47 -0400
Date: Mon, 7 Jul 2003 23:48:18 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [2.4.21] VESAFB ,YWRAP and screen glitches
From: Lia Maggioni <voloterreno@tin.it>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B899CEA8-B0C4-11D7-804B-00039387DFA2@tin.it>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've solved the problem about the activation of YWRAP, but now I've 
found another problem, and this time I think that it is a real BUG or 
somthing like that.

When I start the system with YWRAP activated I have scrolling problems , 
in fact when I make the screen scrolling for a while (for example during 
the examination of a document with "less" or during the compilation of a 
software) , on the screen starts appear colored lines on the screen and 
these starts scrolling . When the screen is full of this lines these 
disappear and the text is back , but after few scroll again these lines 
appears. With 2.4.21-ac4 kernel the problem is more evident than the 
2.4.21 "vanilla" .  If I reboot the system doesn't appears lines 
anymore, but instead of the lines appears words of the precedent boot of 
the system, seems like that the video memory have not been reset , and 
that the FB takes parts of the Video data Junk remained after the reboot 
and visualize these on the screen. Seems like an error in addressing the 
video memory .

With 2.4.20 and precedent this doesn't happen .

Please help me :cry:

Bye

marcello

