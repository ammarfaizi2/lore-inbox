Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWHIWoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWHIWoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHIWo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:44:29 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:38472 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751411AbWHIWo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:44:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZEIz3mXeHEeVYqKUmCUDXVvGEgRnul6TTDlXfKHwcuwYmH73Wbumv0FBbMzm4cNCppegnDS1NdCwUgMplXbrpHp5UilCQrnN63v5MNfoC6aM4ZHdYJxuYrsZPTyWlVOtfYUouELhN7Z62lYVMWU4ibSK2J1tyTePCLBcviDaT8s=
Message-ID: <6bffcb0e0608091544l376c37c6j5c766b38426c318b@mail.gmail.com>
Date: Thu, 10 Aug 2006 00:44:28 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: "Jens Axboe" <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608090720g2ac739desd25a77e3c98ef268@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	 <6bffcb0e0608090720g2ac739desd25a77e3c98ef268@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> >
> >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> >
>
> When I want to halt system I type "init 0", but it stops on
>
> Halting system...
> Synchronizing SCSI cache for disk sda
> Shutdown: hda
>
> Problem appears on 2.6.18-rc3-mm*. I guess that this is an IDE or ACPI bug.
> I'll revert IDE and ACPI patches. If it won't help, I'll do binary search.

It's a git-block.patch

Jens, can you look at this?

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config2

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
