Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263712AbUEDBrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbUEDBrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUEDBru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:47:50 -0400
Received: from ns.clanhk.org ([69.93.101.154]:6818 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S263712AbUEDBrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:47:49 -0400
Message-ID: <4096F676.7080305@clanhk.org>
Date: Mon, 03 May 2004 20:48:38 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting off of IDE while using different libata drives on same
 southbridge
References: <200403121826.21442.markus.kossmann@inka.de> <200405032344.58597.bzolnier@elka.pw.edu.pl> <4096EA32.10201@clanhk.org> <200405040321.03110.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405040321.03110.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Just don't compile generic IDE PCI driver!!
>
>CONFIG_BLK_DEV_GENERIC=n
>
>VIA PATA controller uses via82cxxx driver not generic IDE PCI one.
>  
>
Ahhh, I knew I was making a mistake.  I didn't realize I was using the 
generic IDE driver.

Thank you sir!
-ryan
