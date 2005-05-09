Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVEIPlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVEIPlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEIPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:41:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:47424 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261431AbVEIPls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:41:48 -0400
Date: Mon, 9 May 2005 17:41:47 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: KC <kcc1967@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_mknod() replacement
Message-ID: <20050509154147.GC5799@harddisk-recovery.com>
References: <5eb4b06505050904172655477c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb4b06505050904172655477c@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 07:17:44PM +0800, KC wrote:
> I found that proc_mknod() had been removed from kernel 2.6.x.
> Any replacement ?
> 
> Or how can I create file, device node or dir from device driver ?

You don't do that from a device driver in the first place. Have a look
at udev, it will do what you want from userspace.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
