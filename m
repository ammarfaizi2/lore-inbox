Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUDHGrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 02:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDHGrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 02:47:18 -0400
Received: from [69.133.187.210] ([69.133.187.210]:5789 "EHLO
	d10systems.homelinux.com") by vger.kernel.org with ESMTP
	id S261624AbUDHGrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 02:47:16 -0400
Date: Wed, 7 Apr 2004 21:46:46 -0400 (EDT)
From: Dhruv Gami <gami@d10systems.com>
X-X-Sender: gami@d10systems.homelinux.com
To: linux-kernel@vger.kernel.org
Subject: setgid - its current use
Message-ID: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: gami@d10systems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

A long time back there was discussion over setuid/setgid and how its been 
replaced by Capabilities (This is what i understood from the 
archives...please correct me if im wrong).

I'd like to know the possibility of using setgid for users to switch their 
groups and work as a member of a particular group. Essentially, if i want 
one user, who belongs to groups X, Y and Z to create a file as a member of 
group Y while he's logged on as a member of group X, would it be possible 
through setgid() ? 

would i need to change all programs that need this capability ? 

or is there a way in the kernel do achieve this ? 

Can i use capabilities in some way to achieve this ?

Any pointers would be really helpful. i don't mind reading up on heavy 
documentation, if i only know where to look. 

Also, im not subscribed to this list, so I'd appreciate it if replies 
could be CC'd to gami@d10systems.com. If there's any other information 
that I should provide to clarify my question, please let me know.

Thanks !

regards,
Gami
-- 
Dhruv Gami
http://d10systems.com
http://d10systems.com/gami

