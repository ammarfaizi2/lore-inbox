Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTL1WvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTL1WvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 17:51:03 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:21745 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262119AbTL1WvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 17:51:01 -0500
Message-ID: <3FEF5E53.1080203@wmich.edu>
Date: Sun, 28 Dec 2003 17:50:59 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 journel aborted in 2.6.0-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what the cause of this type of error is but i've only seen it 
in the very late test releases of 2.6.0 and now in the mm1 patch (i've 
always used the mm branch of the test releases).  It seems to like to 
happen to my partition that has /var/ on it during an updatedb and log 
rotate that is standard practice in most distributions. I'm using debian 
  unstable if that helps narrow the problem down, however it seems more 
likely to be a kernel problem possibly in one of the patches that's been 
in mm's tree for very recent test, and now release, kernels.


