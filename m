Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUD1ELV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUD1ELV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUD1ELV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:11:21 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:34764 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264633AbUD1EKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 00:10:54 -0400
Date: Wed, 28 Apr 2004 14:00:35 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: What does tainting actually mean?
Reply-To: ncunningham@linuxmail.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm probably going to regret this, but seeing the current discussion on  
binary modules makes me wonder:

What does tainting actually mean?

What I mean is, how does it help to know that a kernel is tainted? When  
I'm working on Software Suspend and someone sends me an oops, I don't  
really care whether it's marked as tainted or not. For all I know, even if  
it's not tainted, they may have thrown in half a dozen different patches  
aside from Suspend, any one of which could be playing a role in the  
appearance of the oops. It doesn't help me to know that the kernel was  
tainted. It helps me to know what the non-standard additions are (and how  
the kernel was configured), regardless of whether the additions mark the  
kernel tainted or not.

Of course I realise at the same time that maybe tainting has nothing to do  
with saying 'This isn't an unmodified tree' and everything to do with  
saying 'This kernel has had non-GPL code interacting with it'. If that's  
the case, I don't see the relevance of saying (as Paul did a little while  
ago):

"You deceived maintainers who receive "untainted" bug reports."

Indeed, the surrounding lines seem to make it clear that the real issue is  
not fixing bugs but politics. Thus my question: What does tainting  
actually mean?

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
