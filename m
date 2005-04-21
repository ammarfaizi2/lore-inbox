Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVDUOC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVDUOC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVDUOC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:02:58 -0400
Received: from open.hands.com ([195.224.53.39]:37264 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261364AbVDUOC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:02:56 -0400
Date: Thu, 21 Apr 2005 15:12:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: noddy question involving /dev/vc/0 and /dev/fb/0 on 2.6.7.11
Message-ID: <20050421141214.GW16160@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, please reply cc to me as well because i am not on these lists
(well i am but the receive post options are switched off), thank you.

i have a "noddy" question where what used to work under 2.4.27
(echo 'hello world' > /dev/vc/0) now doesn't work on 2.6.7.11,
even though echo 'garbage' > /dev/fb/0 does - just like it
used to on 2.4.27.

this is with an arm embedded system i'm developing for (CLPS711x
derivative) and i have it set up so that the console is on the serial
port.

i have ported the framebuffer device over to 2.6, and have it working
(echo garbage > /dev/fb/0 shows up garbage in the top left corner).

what kernel options do i need such that echo 'hello world' >
/dev/vc/0 will work and i get my lovely flashing cursor back?

many thanks,

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
