Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTJONdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJONdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:33:10 -0400
Received: from users.linvision.com ([62.58.92.114]:61373 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263195AbTJONdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:33:08 -0400
Date: Wed, 15 Oct 2003 15:33:05 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Josh Litherland <josh@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015133305.GF24799@bitwizard.nl>
References: <1066163449.4286.4.camel@Borogove>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066163449.4286.4.camel@Borogove>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 04:30:50PM -0400, Josh Litherland wrote:
> Are there any filesystems which implement the transparent compression
> attribute ?  (chattr +c)

The NTFS driver supports compressed files. Because it doesn't have
proper write support, I don't think it will do anything useful with
chattr +c.

Nowadays disks are so incredibly cheap, that transparent compression
support is not realy worth it anymore (IMHO).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
