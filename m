Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUJDIjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUJDIjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUJDIjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:39:47 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:34690 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S267826AbUJDIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:39:39 -0400
Message-ID: <41610C0B.6090305@smallworld.cx>
Date: Mon, 04 Oct 2004 09:38:35 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with Highpoint driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an Itox G4C600 motherboard with on board Highpoint HPT366/370 ide
controller. I am trying to use the 4 available IDE channels separately
(i.e. not as raid). The hpt366 driver sees drives on the 1st channel but 
not on the 2nd. The Highpoint bios sees all drives.

I tried Highpoint's driver and it sees all drives work (although they 
used the scsi interface which is not good for me).

I had also tried a different board (same model) and this had the odd 
problem of seeing different combinations of the disks depending on how
the SATA was configured in the BIOS.

Kernel is 2.4.28-pre3. Ideas welcome. Thanks.


-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
