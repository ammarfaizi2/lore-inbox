Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUBWHVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 02:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUBWHVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 02:21:19 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:18077 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261153AbUBWHVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 02:21:18 -0500
Message-ID: <4039A9EE.8040801@blueyonder.co.uk>
Date: Mon, 23 Feb 2004 07:21:18 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm3 smbfs compile error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2004 07:21:18.0226 (UTC) FILETIME=[A1176720:01C3F9DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:554: warning: comparison is always false due to limited 
range of data type
fs/smbfs/inode.c:555: warning: comparison is always false due to limited 
range of data type
  CC [M]  fs/smbfs/file.o
fs/smbfs/file.c:284: error: redefinition of `smb_file_sendfile'
fs/smbfs/file.c:263: error: `smb_file_sendfile' previously defined here
fs/smbfs/file.c:263: warning: `smb_file_sendfile' defined but not used
make[2]: *** [fs/smbfs/file.o] Error 1
make[1]: *** [fs/smbfs] Error 2
make: *** [fs] Error 2
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

