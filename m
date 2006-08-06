Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWHFLJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWHFLJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHFLJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 07:09:27 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:35892 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWHFLJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 07:09:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLh0o8KMdG9buZ6s3nrfy6ilvREUSCEkH5hgvxrDiym8310oWyzxBmbHc17qvOh+Nv1z5/sKoLIJKILMqdI9/XVXIQ87a87wlzsTZZN2xpXaGwjbJkbIUvJbkbS96hDM9elRmZ7HbPWNqpEiagMJ6O1LMP3I8tkNcpGoTc+PjRg=
Message-ID: <6bffcb0e0608060409m2cd8fb4er6d7d2300915604c4@mail.gmail.com>
Date: Sun, 6 Aug 2006 13:09:25 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Jay Lan" <jlan@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/08/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>

I get this error during the build.

kernel/built-in.o: In function `bacct_add_tsk':
/usr/src/linux-mm/kernel/tsacct.c:39: undefined reference to `__divdi3'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

I'll try with CONFIG_TASKSTATS disabled.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
