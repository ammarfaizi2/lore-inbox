Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268844AbUIHQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268844AbUIHQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:40:37 -0400
Received: from eh3.com ([66.220.5.62]:24778 "HELO eh3.com")
	by vger.kernel.org with SMTP id S268844AbUIHQkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:40:35 -0400
Subject: 3ware 9500 ("3w-9xxx") w/ dual Opteron (Tyan 2885)
From: Ed Hill <ed@eh3.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1094661631.13662.2808.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 12:40:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

Has anyone managed to get a 3ware 9500-series RAID controller working
stably on an SMP Opteron system?  Especially with a Tyan 2885 MB?  If
so, would you be willing to share your kernel configuration info?

I'm trying to get a 3ware 9500 8-port card working on a Tyan 2885
motherboard (dual Opterons) and have been experiencing numerous oopses:

  - 2.6.[78] w/ the included 3w-9xxx driver and ext3 FS:
    Results in kernel oops after 1--2 hours of writing to the 
    RAID array (happened four times).  The oops appears to be 
    in ext3.

  - 2.6.8.1 w/ latest 3w-9xxx driver from 3ware and XFS FS:
    Results in "Bad page state at prep_new_page" kernel errors

When not using the 3ware RAID array (that is, the array is mounted but
no reads or writes are done to it), the machine is very stable--even
under heavy CPU loads and lots of IO to local (non-RAID) IDE drives.

Any help/suggestions appreciated!

Ed

-- 
Edward H. Hill III, PhD
office:  MIT Dept. of EAPS;  Rm 54-1424;  77 Massachusetts Ave.
             Cambridge, MA 02139-4307
emails:  eh3@mit.edu                ed@eh3.com
URLs:    http://web.mit.edu/eh3/    http://eh3.com/
phone:   617-253-0098
fax:     617-253-4464

