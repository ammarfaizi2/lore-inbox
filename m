Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUHGNDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUHGNDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 09:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUHGNDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 09:03:46 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:22278 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261987AbUHGNDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 09:03:44 -0400
Date: Sat, 7 Aug 2004 15:03:41 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS errors
Message-ID: <20040807130338.GB18603@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during a recent upgrade of the distribution (Debian Unstable) on my 
laptop, I accidentally filled the entire root partition (hda1). apt-get 
complained accordingly as some packages failed to be updated (no space 
left on device errors filled half of the console).

After freeing some more space, I reinstalled the packages which had 
failed installation, only to discover later that some files from the 
packages which where supposed to have been installed just fine were 
corrupt.

In the kernel logs I also saw this message repeated 20 or so times:
ReiserFS: hda1: warning: vs-8115: get_num_ver: not directory item

As there was now space on the device, a quick reinstall of the damaged 
packages rectified the situation, but my question is if this is an error 
in reiserfs? (I've experienced the exact same thing a few months ago, 
also then when the partition was full).

Hardware is an IBM G40 laptop with ICH4 IDE chipset, unknown HD 
(reported as IC25N040ATMR04-0) and kernel 2.6.6-mm4.

Please CC me on any replies.

Regards,
David Härdeman
david (AT) 2gen (dot) com

