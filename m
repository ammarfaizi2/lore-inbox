Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUBWPlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUBWPlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:41:37 -0500
Received: from smtp-out7.blueyonder.co.uk ([195.188.213.10]:21263 "EHLO
	smtp-out7.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261939AbUBWPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:39:37 -0500
Message-ID: <403A1EB3.70901@blueyonder.co.uk>
Date: Mon, 23 Feb 2004 15:39:31 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm3 smbfs compile error
References: <4039A9EE.8040801@blueyonder.co.uk> <20040223011249.2fa12002.akpm@osdl.org>
In-Reply-To: <20040223011249.2fa12002.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2004 15:39:32.0582 (UTC) FILETIME=[3B842060:01C3FA23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>  
>
>>  CC [M]  fs/smbfs/inode.o
>>fs/smbfs/inode.c: In function `smb_fill_super':
>>fs/smbfs/inode.c:554: warning: comparison is always false due to limited 
>>range of data type
>>fs/smbfs/inode.c:555: warning: comparison is always false due to limited 
>>range of data type
>>  CC [M]  fs/smbfs/file.o
>>fs/smbfs/file.c:284: error: redefinition of `smb_file_sendfile'
>>fs/smbfs/file.c:263: error: `smb_file_sendfile' previously defined here
>>fs/smbfs/file.c:263: warning: `smb_file_sendfile' defined but not used
>>make[2]: *** [fs/smbfs/file.o] Error 1
>>make[1]: *** [fs/smbfs] Error 2
>>make: *** [fs] Error 2
>>    
>>
>
>It's OK here.   Probably something went wrong in the patching process.
>
>  
>
Thanks, after make mrproper I got the same error. A new 2.6.3 tree and 
mm3 patch is OK.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

