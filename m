Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRGFDRw>; Thu, 5 Jul 2001 23:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbRGFDRm>; Thu, 5 Jul 2001 23:17:42 -0400
Received: from gecko.roadtoad.net ([209.209.8.2]:1021 "EHLO gecko.roadtoad.net")
	by vger.kernel.org with ESMTP id <S265844AbRGFDRe>;
	Thu, 5 Jul 2001 23:17:34 -0400
Date: Thu, 5 Jul 2001 20:17:28 -0700 (PDT)
From: Derek Vadala <derek@cynicism.com>
To: linux-kernel@vger.kernel.org
Subject: max sizes for files and file systems
Message-ID: <Pine.GSO.4.21.0107052009500.28636-100000@gecko.roadtoad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to do some research on the file size and filesystem size
limitations under Linux for stable releases since 2.0. 

It's clear that under 2.4, the kernel imposes a limit of 2TB as the
maximum file size and that some portion of the kernels before 2.4 had a
limit of 2GB.

However, it's not clear to me when the file size limit was increased, or
what the maximum file system sizes under 2.0, 2.2 and 2.4 are. I realize
that both of these values are also contingent on the filesystem used, but
I'm wondering about what limits the kernel itself imposes. 

I'm also a bit unclear as to where the 2GB limit in kernels < 2.4 comes
from. It appears to be a kernel imposed limit, but there also seems to be
a lot conflicting information out there, blaming the problem on
EXT2. However, from what I can tell, 2.0.39, 2.2.19 and 2.4.5 all use the
same version (0.5b-95/08/09) of ext2-- either that or EXT2FS_VERSION and
EXT2FS_DATE in .../include/linux/ext2_fs.h simply haven't been updated.

Any clarification would be appreciated.

---
Derek Vadala, derek@cynicism.com, http://www.cynicism.com/~derek

