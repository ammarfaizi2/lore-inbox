Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBZNsb>; Tue, 26 Feb 2002 08:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBZNsV>; Tue, 26 Feb 2002 08:48:21 -0500
Received: from [12.38.223.195] ([12.38.223.195]:54372 "HELO
	starentnetworks.com") by vger.kernel.org with SMTP
	id <S287408AbSBZNsI>; Tue, 26 Feb 2002 08:48:08 -0500
Message-ID: <3C7B9212.5050400@sw.starentnetworks.com>
Date: Tue, 26 Feb 2002 08:48:02 -0500
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel nfsd consuming 100% CPU on 2.4.17 and 2.4.18 with reiserfs?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that kernel nfsd consumes an inordinate amount of CPU time 
during writes on this machine. With a few hundred kb/sec being written 
over NFSv3 from a 2.2.17 client, all of the nfsd threads each consume as 
much of the available CPU time as possible. On a similarly configured 
machine with ext3 instead of reiserfs, nfsd consumes much less CPU time.

Is there a known issue with NFSv3 performance and reiserfs?

-- 
Brian Ristuccia

