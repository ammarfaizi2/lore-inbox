Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTENWrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTENWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:47:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:63013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263077AbTENWrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:47:12 -0400
Message-ID: <3EC2CA63.6030301@gmx.net>
Date: Thu, 15 May 2003 00:59:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <200305141829_MC3-1-38F1-59C7@compuserve.com>
In-Reply-To: <200305141829_MC3-1-38F1-59C7@compuserve.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> hpa wrote:
> 
> 
>>How about creating a master option like we have for experimental?
>>Something like "Allow removal of essential components?" (CONFIG_EMBEDDED)
> 
> 
>   ...and that just enables another option: "REALLY allow removal of
> essential components?" (CONFIG_REALLY_EMBEDDED)
> 
>  :)

Reminds me of CONFIG_MORON back in December 2000

-dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW
$CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
+dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_MORON
$CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
+dep_bool  '    Are you sure?  I hope you dont care about your NTFS
filesystems' CONFIG_NTFS_RW $CONFIG_MORON

;)


Carl-Daniel
-- 
And the mailer looked at the patch and, behold, it was good. And the
mailer decided to wrap the patch.

