Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVHXIBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVHXIBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVHXIBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:01:19 -0400
Received: from mail.wp-sa.pl ([212.77.102.105]:44527 "EHLO mail.wp-sa.pl")
	by vger.kernel.org with ESMTP id S1750755AbVHXIBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:01:18 -0400
Date: Wed, 24 Aug 2005 10:01:08 +0200
From: Mariusz Zielinski <levi@wp-sa.pl>
X-Face: '2=UjhX-y3vfeO94nyru(,e&{Lf^eJ&15S#rcuk:e{unjSRN4yZ69Z'ePMJsPO"=?utf-8?q?6=5Cs=27iVZ=0A=090OZ?=>_
Subject: Re: debug a high load average
In-reply-to: <430BFA58.6090609@gmail.com>
To: Rajesh <rvarada@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200508241001.11464.levi@wp-sa.pl>
Organization: Wirtualna Polska SA
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.1
References: <430B03B4.8040205@gmail.com>
 <20050823133050.GC29062@harddisk-recovery.com> <430BFA58.6090609@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 06:40, you wrote:
[...]
> I am running  2.6.12 kernel on a laptop. I have an ipod attached to my
> USB 1.1 as a drive on which I am saving and retreiving large
> files(2-4GiB files). 
[...]

Check if you are not using low performance usb driver (CONFIG_BLK_DEV_UB).
If I remember correctly it uses /dev/ub* devices.

-- 
Mariusz Zielinski
