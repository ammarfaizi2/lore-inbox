Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285827AbRLHFWM>; Sat, 8 Dec 2001 00:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbRLHFWC>; Sat, 8 Dec 2001 00:22:02 -0500
Received: from dsl081-242-114.sfo1.dsl.speakeasy.net ([64.81.242.114]:30856
	"EHLO drscience.sciencething.org") by vger.kernel.org with ESMTP
	id <S285827AbRLHFVm>; Sat, 8 Dec 2001 00:21:42 -0500
Message-ID: <3C11A2E7.5070306@sciencething.org>
Date: Fri, 07 Dec 2001 21:19:35 -0800
From: Britt Park <britt@drscience.sciencething.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The demise of notify_change.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhen between 2.2.x and 2.4.x notify_change disappeared from 
super_operations.  What is the accepted practice now for updating an 
inode's persistent state?  Should one use write_inode for the same 
purpose or should one rely on file_operations::setattr (excuse the 
c++ism)? Or is there something entirely different that one should do?

With apologies for being behind the times (I'm trying to update a 
filesystem I wrote for 2.0.x, which fact dates me accurately.),

Britt

P.S. I promise to send REG amendments to his VFS doc when I get done.

