Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUCRQgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUCRQgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:36:11 -0500
Received: from lx.quiotix.com ([199.164.185.7]:23739 "EHLO lx.quiotix.com")
	by vger.kernel.org with ESMTP id S262742AbUCRQgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:36:10 -0500
Message-ID: <4059CFF2.6060209@quiotix.com>
Date: Thu, 18 Mar 2004 08:36:02 -0800
From: Jeffrey Siegal <jbs@quiotix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is fsync so much slower than O_SYNC?
References: <40587F90.1040903@quiotix.com> <20040318003335.6bf3eb41.akpm@osdl.org>
In-Reply-To: <20040318003335.6bf3eb41.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some odd results on ext2 as well:

README: Make sure you have turned off hardware write caching (hdparm -W0 
/dev/hda for IDE)

O_SYNC:
Creating
Starting
iter = 1000, latency = 8.419908ms

O_DSYNC:
Creating
Starting
iter = 1000, latency = 8.369892ms

fsync:
Creating
Starting
iter = 1000, latency = 13.191030ms

fdatasync:
Creating
Starting
iter = 1000, latency = 8.829373ms

