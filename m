Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWBMJYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWBMJYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWBMJYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:24:08 -0500
Received: from main.gmane.org ([80.91.229.2]:22155 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751671AbWBMJYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:24:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Filesystem for mobile hard drive
Date: Mon, 13 Feb 2006 18:23:42 +0900
Message-ID: <dspj6u$s7f$1@sea.gmane.org>
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060207)
In-Reply-To: <43EFEE57.7070009@cfl.rr.com>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Nicolas George wrote:

[snip]

>> I believe that such options should not be done on a per-filesystem basis.
>> Something in the common code of the VFS would be more logical.
> 
> I agree.  I think the VFS layer should process the uid/gid options.  By
> default it should replace nobody with the specified id, and fat and ntfs
>  should just report all files as owned by nobody.  Then a new option
> should be added to force the translation for all ids, not just nobody.

I might be wrong, but I always thought that NTFS has user/group and a bunch
of other attributes, so it might not be a good idea to replace them hard
under linux. Or am I wrong? I never used NTFS much, the few windoze machines
around me use FAT32 for compatibility.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

