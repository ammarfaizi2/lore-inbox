Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312497AbSDNXn6>; Sun, 14 Apr 2002 19:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSDNXn5>; Sun, 14 Apr 2002 19:43:57 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:7684
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S312497AbSDNXn5>; Sun, 14 Apr 2002 19:43:57 -0400
Subject: Is this right?
From: Shawn Starr <spstarr@sh0n.net>
To: Linux <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 14 Apr 2002 18:45:49 -0400
Message-Id: <1018824351.290.1.camel@coredump>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should Buffers/Memshared be 0 kB? Is this memory buffers/shared or disk
buffers/shared?

I'm using XFS filesystem.

[spstarr@coredump spstarr]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  62586880 61825024   761856        0        0 35803136
Swap: 186654720 35758080 150896640
MemTotal:        61120 kB
MemFree:           744 kB
MemShared:           0 kB
Buffers:             0 kB

Shawn.


