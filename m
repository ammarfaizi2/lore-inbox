Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTDGCXS (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTDGCXR (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:23:17 -0400
Received: from mail.gmx.de ([213.165.65.60]:26736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263195AbTDGCXQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:23:16 -0400
Message-ID: <3E90E3C5.80109@gmx.net>
Date: Mon, 07 Apr 2003 04:34:45 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
References: <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
In-Reply-To: <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> Since 2.4.20 I have not been able to boot Linux using more recent kernels
> (tried 21-pre3, -pre6).
> 
> The problem is that my /home is on a raid5 disks array connected to a PDC20276 
> motherboard-mounted controller. The BIOS boots and detects all 4 disks, and 
> then enables IDE Master mode, as expetced. The kernel in 2.4.20 then uses the 
> disks in IDE master mode, but the pre3 and pre6 kernels say the BIOS hasn't 
> enabled the controller.

Could you please try 2.4.21-pre7 (this has another batch of IDE updates) 
and enable the option
"Special FastTrak Feature"?
In your .config, the option would be
CONFIG_PDC202XX_FORCE=y
and report back to the list?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org

