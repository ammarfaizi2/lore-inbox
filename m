Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVACX5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVACX5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVACX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:56:52 -0500
Received: from terminus.zytor.com ([209.128.68.124]:11938 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262016AbVACXzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:55:53 -0500
Message-ID: <41D9DB5E.4040500@zytor.com>
Date: Mon, 03 Jan 2005 15:55:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael B Allen <mba2000@ioplex.com>
CC: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com>    <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>    <41D9D65D.7050001@zytor.com> <53299.199.43.32.68.1104796121.squirrel@li4-142.members.linode.com>
In-Reply-To: <53299.199.43.32.68.1104796121.squirrel@li4-142.members.linode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael B Allen wrote:
>>
>>Thus, I'd propose:
>>
>>	system.dosattrib	- DOS attributes (single byte)
>>	system.dosshortname	- DOS short name (e.g. for VFAT)
> 
> 
> Oh, from the man page I thought 'system' attributes were "extended
> attributes to which ordinary processes should not have access". Is that
> not true? If it is true, how would an ordinary user change these attrs?
> 

Nah:

    Extended system attributes
        Extended system attributes are used by the kernel to store  sys-
        tem objects such as Access Control Lists and Capabilities.  Read
        and write access permissions to system attributes depend on  the
        policy  implemented  for  each  system  attribute implemented by
        filesystems in the kernel.

It's not *that* broken...

	-hpa
