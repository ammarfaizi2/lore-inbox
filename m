Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272575AbTHBKxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTHBKxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:53:31 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:38340 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S272575AbTHBKxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:53:30 -0400
Message-ID: <3F2B9823.7010503@Synopsys.COM>
Date: Sat, 02 Aug 2003 12:53:23 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2: crash in reiserfs at shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I get a reproducable system crash in reiserfs at shutdown
time, when my external USB disk is going to be unmounted.

Final words are

	kernel BUG at fs/reiserfs/prints.c: 339

plus a lot of more lines. If I umount the disk at normal
runtime, then there is no problem.

I would be glad to help to get this fixed, but before I
manually write down all the other lines: Is anybody
interested in this? Or is this a well known problem?


Regards

Harri

