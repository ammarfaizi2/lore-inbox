Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVEZM3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVEZM3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVEZM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:29:52 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37428 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261348AbVEZM3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:29:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=majUueL6vqTDU1sMoMCTOrwsm2YAioMIYhsAnx95eOqg4KhZAM5fGUFfwnjmr7iFlBWVPtOmqJpBFYxMgXbcSXjkmHOnosBPqrmWRCNEGg0/jKGlX53bDMBymXyCXn3KApuRqxW2qSuzM+QuvlMc8gdHt4GqP8uLZsFg3IznIes=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12-rc5 build failure
Date: Thu, 26 May 2005 16:34:17 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200505260750.57571.gene.heskett@verizon.net>
In-Reply-To: <200505260750.57571.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261634.17849.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 15:50, Gene Heskett wrote:
> Just now, trying to build 2.6.12-rc5, I'm getting this:
>   CC      drivers/char/ipmi/ipmi_devintf.o
> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
> drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of `class_simple_device_add' from incompatible pointer type
> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
> drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of `class_simple_device_remove' makes integer from pointer without a cast
> drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to function `class_simple_device_remove'

Fixed in 2.6.12-rc5-dca79a046b93a81496bb30ca01177fb17f37ab72.

http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dca79a046b93a81496bb30ca01177fb17f37ab72;hp=5daf05fbf73fc199e7a93a818e504856d07c5586
