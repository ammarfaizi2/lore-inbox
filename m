Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUANSeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUANSeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:34:05 -0500
Received: from users.linvision.com ([62.58.92.114]:43992 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262714AbUANSbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:31:45 -0500
Date: Wed, 14 Jan 2004 19:31:43 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Migrating 2.4.x to 2.6.x Question (include files)
Message-ID: <20040114183143.GD32063@bitwizard.nl>
References: <Pine.LNX.4.53.0401141051320.430@kryx.sk-tech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401141051320.430@kryx.sk-tech.net>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:00:00AM +0100, Kianusch Sayah Karadji wrote:
> I'm trying to install kernel 2.6.1 on a freshly installed Debian woody.
> 
> Well I got it working but ...
> 
> On 2.4.x I used to (soft) link
> 
>   /usr/src/linux-2.4.x/include/linux to /usr/include/linux

[...]

> Which is probably not the correct way :( - What am I missing?

None of them. You shouldn't link the kernel headers at all. See:

  http://www.kernelnewbies.org/faq/index.php3#headers

Debian has been doing it the right way for quite some time.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
