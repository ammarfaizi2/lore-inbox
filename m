Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVAJWAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVAJWAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAJV71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:59:27 -0500
Received: from gw.unix-scripts.info ([62.212.121.13]:13012 "EHLO
	gw.unix-scripts.info") by vger.kernel.org with ESMTP
	id S262562AbVAJVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:48:21 -0500
Message-ID: <41E2F823.1070608@apartia.fr>
Date: Mon, 10 Jan 2005 22:48:19 +0100
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unable to burn DVDs
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
growisofs.

It seems there is a problem

Here is the output


# growisofs -Z /dev/scd0 -R -J ~/foobar

WARNING: /dev/scd0 already carries isofs!
About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd 
of=/dev/scd0 obs=32k seek=0'
INFO:ingISO-8859-15 character encoding detected by locale settings.
        Assuming ISO-8859-15 encoded filenames on source filesystem,
        use -input-charset to override.
Total translation table size: 0
Total rockridge attributes bytes: 252
Total directory bytes: 0
Path table size(bytes): 10
/dev/scd0: "Current Write Speed" is 4.1x1385KBps.
:-[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
:-( write failed: Input/output error


Needless to say it works fine with 2.6.9

Am I missing something?

Thanks

Laurent

-- 
The only "intuitive" interface is the nipple.  After that, it's all learned.
	-- Bruce Ediger, bediger@teal.csn.org, on X interfaces

