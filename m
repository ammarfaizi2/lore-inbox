Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUHDNqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUHDNqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUHDNqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:46:19 -0400
Received: from users.linvision.com ([62.58.92.114]:48069 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265795AbUHDNpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:45:50 -0400
Date: Wed, 4 Aug 2004 15:45:49 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: walt <wa1ter@myrealbox.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-bk] New read/write bug in FAT fs
Message-ID: <20040804134549.GD25969@harddisk-recovery.com>
References: <4110CF29.8060401@myrealbox.com> <87657zkp21.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87657zkp21.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 10:31:18PM +0900, OGAWA Hirofumi wrote:
> This is intention.
> 
> The default codepage/iocharset which is easy to cause a mistake and
> unclear was deleted from fatfs. So default is mounted as read only.
> 
> You need to explicitly specify the "codepage" and "iocharset" options.

To minimise confusion, is it an idea that NTFS and FAT use the same
mount options? Right now NTFS uses "nls" and VFAT "iocharset".


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
