Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUIUP1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUIUP1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIUP1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:27:42 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:25001 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267751AbUIUP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:27:36 -0400
Message-ID: <4150485E.6000501@nortelnetworks.com>
Date: Tue, 21 Sep 2004 09:27:26 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: journalling filesystems, linux 2.4.22, SATA drives
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for recommendations on how to deal with the possibility of 
filesystem corruption.

As in the subject, I'm on 2.4.22, with SATA drives.

 From what I've read, the safest thing to do is to turn off the write cache and 
use a journalled filesystem.  However the hardware guy says that turning off the 
write cache also turns off the automatic error correction on writes, so the 
write may return an error rather than being remapped silently.

What's the best way for me to deal with this?

Chris
