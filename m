Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbUDSLjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUDSLjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:39:21 -0400
Received: from users.linvision.com ([62.58.92.114]:57565 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264370AbUDSLjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:39:03 -0400
Date: Mon, 19 Apr 2004 13:39:01 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Remi Colinet <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040419113901.GC19397@harddisk-recovery.com>
References: <4082819E.10106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4082819E.10106@free.fr>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:24:46PM +0200, Remi Colinet wrote:
> I have 2 questions about disk partitioning under linux 2.6.x :
> 
> 1/ Is it possible to alter a disk partition of a used disk and beeing 
> able to use the modified partition without having to reboot the box?

"blockdev --rereadpt /dev/whatever" does the trick on 2.4.x. Didn't try
it on 2.6 yet, but I don't think it changed.

> 2/ Is it possible to delete a disk partition without having the 
> partition numbers changed?

Yes (assuming MS-DOS style partition tables).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
