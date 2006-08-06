Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHFUrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHFUrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWHFUrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:47:17 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:59398 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750709AbWHFUrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:47:17 -0400
Date: Sun, 6 Aug 2006 22:47:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: andy <andy@squeakycode.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asus m5n, i2c-i805 missing temp1_auto_temp_min
Message-Id: <20060806224715.2bfe074a.khali@linux-fr.org>
In-Reply-To: <44D6383E.7050000@squeakycode.net>
References: <44D6383E.7050000@squeakycode.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> I have an asus m5n laptop, with kernel 2.6.16.9, and this works:
> 
> if cd '/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e'; then
>      echo 55000 > temp1_auto_temp_min
>      echo 50000 > temp1_auto_temp_off
> fi
> 
> However in kernel 2.6.16.27, and 2.6.17.7 it does not.  It reports that 
> directory is not found (I can get to '/sys/devices/pci0000:00/' and 
> thats it).  Its only for setting the fan on/off temp's, so its not a big 
> deal, but it makes my laptop quieter when its not doing anything, so I 
> kinda like it.
> 
> Is there a new way of doing this?  Or was it moved to another module? 
> Or broken?

Done on purpose.

Please see this thread:
http://lkml.org/lkml/2006/7/26/249

-- 
Jean Delvare
