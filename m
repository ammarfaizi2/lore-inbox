Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRCIXXZ>; Fri, 9 Mar 2001 18:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130757AbRCIXXP>; Fri, 9 Mar 2001 18:23:15 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:9770 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130756AbRCIXXD>;
	Fri, 9 Mar 2001 18:23:03 -0500
Message-ID: <3AA9653B.B691C8F2@sgi.com>
Date: Fri, 09 Mar 2001 15:20:27 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (struct dentry *)->vfsmnt;
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone enlighten me as to the purpose of this field in the
dentry struct?  There is no elucidating comment in the header for this
particular field and the name/type only indicate it is pointing to
a list of vfsmounts.  Can a dentry belong to more than one vfsmount?

If I have a 'dentry' and simply want to determine what the absolute
path from root is, in the 'd_path' macro, would I use 'rootmnt' of my
current->fs as the 'vfsmount' as well?

Thanks, in advance...
-linda


-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-53
