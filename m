Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTELOiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTELOiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:38:01 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64445 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262169AbTELOh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:37:59 -0400
Date: Mon, 12 May 2003 05:36:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 705] New: using xmodmap to reverse mouse buttons, causes button 3 to behave as though 1 & 3 both pressed
Message-ID: <21400000.1052742983@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=705

           Summary: using xmodmap to reverse mouse buttons, causes button 3
                    to behave as though 1 & 3 both pressed
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: tonyagee@earthlink.net


Distribution: RH9
Hardware Environment:
  Machine A: Athlon 1.2, via686b/8233, IMPS/2 mouse (MS Optical)
  Machine B: Duron 650, via586a, IMPS/2 (MS wheel mouse)
Software Environment: XFree86 4.3.0 (RedHat dist.)
Problem Description: I have an xmodmap command in my .Xclients-default, to
reverse my mouse buttons. Works fine anywhere but in 2.5.69 from kernel.org. 
With 2.5.69 running,  button 3 both invokes desktop menus and executes items
from them, while button 1  seems not to work at all. If I run xmodmap -e
"pointer = 1 2 3 4 5" then the mouse behaves normally for a right-handed mouse.
Which doesn't suit me at all :-(

Steps to reproduce:
xmodmap  -e "pointer = 3 2 1 4 5"
click button 3 on desktop
 <context menu appears>


