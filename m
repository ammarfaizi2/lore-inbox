Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWGZSyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWGZSyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGZSyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:54:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:46974 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750876AbWGZSyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:54:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f2EB02m8NuzvTOAvQUH0t/JfC3TwhI+h0a0mcQCSlT5E6wSkxj/J3wwGw4UZ8WPcIvaHYg5FtPXlk5JeP6thVGMWO43S07fAHmls+mA6ay1KCZNnvr2n+6ujVMvOF/J70iUvREi+dNKE80jr+wygS9mYigOtRbLKaX7McUsSE+E=
Message-ID: <5d6b65750607261154q7ca21742q8dd69e4e08ff86fa@mail.gmail.com>
Date: Wed, 26 Jul 2006 20:54:12 +0200
From: "Buddy Lucas" <buddy.lucas@gmail.com>
To: "Bernd Eckenfels" <be-news06@lina.inka.de>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1G5j2B-0005eW-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060726112039.GA18329@merlin.emma.line.org>
	 <E1G5j2B-0005eW-00@calista.eckenfels.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Bernd Eckenfels <be-news06@lina.inka.de> wrote:
>
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > But the assertion that some backup was the cause for inode exhaustion on
> > ext? is not very plausible since hard links do not take up inodes,
> > symlinks are not backups and everything else requires disk blocks. So,
> > since reformatting ext2/ext3 to one inode per block is possible
> > (regardless of disk capacity), I see no way how a reformatted file
> > system might run out of inodes before it runs out of blocks.
>
> Well I had actually the problem on a tmpfs where I had too many zero byte
> files...

Yes, I once ran out of inodes because logrotate kept rotating and
compressing already compressed and empty logfiles. I can't remember
how many seconds it took me to add 'df -i' to our monitoring system.

This, however, was not a feature of the software. I assume.

So, any company that considers the remote possibility of seeking a
$250,000 solution, where the alternative is to buy a 36GB hard drive,
please give me a call.


Cheers,
Buddy
