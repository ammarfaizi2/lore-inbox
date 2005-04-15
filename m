Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVDOTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVDOTPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVDOTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:15:43 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:4750 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261929AbVDOTPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:15:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kX5QfQJMwllUeS2pEDbOcbFXlNCazODT7S83uwVZbYPo6BgBm2HFk4w/+r9SrkdueB8DR6jz2gTsAx2rot4U499OuG/Ito42RpBpgMaF0w2G2Vvzokq1TKv3nF/OBTzF5KVwZKWwH65R+b+s1ha/z4JBbBL0gCoffzDdGat4Qmg=
Message-ID: <17d7988050415121537c8fac1@mail.gmail.com>
Date: Fri, 15 Apr 2005 19:15:36 +0000
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't the kernel code segment marked read-only ? How can the module
write into the function text in the kernel ? Shouldn't this cause some
kind of protection fault ?

thanks,
Allison

Lee Revell wrote:
> On Fri, 2005-04-15 at 18:15 +0000, Allison wrote:
> > Once these are loaded into the kernel, is there no way the kernel
> > functions can be protected ?
> 
> No.  If the attacker can load arbitrary code into the kernel, game over.
> Think about it.
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
