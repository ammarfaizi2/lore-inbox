Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUECVS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUECVS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUECVS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:18:29 -0400
Received: from ns.clanhk.org ([69.93.101.154]:20639 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264019AbUECVS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:18:27 -0400
Message-ID: <4096B752.9050602@clanhk.org>
Date: Mon, 03 May 2004 16:19:14 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Booting off of IDE while using different libata drives on same southbridge
References: <200403121826.21442.markus.kossmann@inka.de> <200403121902.44371.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403121902.44371.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a similar problem to what Markus Kossmann wrote about, but 
with the VIA Southbridge (Asus K8V).  My situation is similar, but a 
little different.  I would like to boot off a PATA drive attached to the 
Southbridge, but use libata for a couple SATA drives attached to the 
same Southbridge.

Is this still not possible?  I also tried hde/hdg=noprobe options, but 
they didn't help the situation.  It appears the only way to get the 
drives on sata_via is to boot off of them.  Am I correct in thinking 
this is the only way to go about this?

-ryan

Bartlomiej Zolnierkiewicz wrote:

>>Is there any chance to use sata_sil with that kernel configuration ?
>>Or is recompiling with CONFIG_BLK_DEV_SIIMAGE=m or with siimage disabled
>>the only option ?
>>    
>>
>
>Yep.
>
>Regards,
>Bartlomiej
>
