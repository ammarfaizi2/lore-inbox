Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbTIOWFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbTIOWFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:05:17 -0400
Received: from smtp-out7.blueyonder.co.uk ([195.188.213.10]:61451 "EHLO
	smtp-out7.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261653AbTIOWFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:05:12 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
Date: Mon, 15 Sep 2003 23:05:36 +0100
User-Agent: KMail/1.5.1
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
In-Reply-To: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309152305.36288.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 15 Sep 2003 22:05:11.0730 (UTC) FILETIME=[6F042920:01C37BD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 September 2003 23:01, Norbert Preining wrote:
> Hi!
>
> I have been using 2.4.23-pre3 without any problems, but when I booted
> 2.4.23-pre4 ide-scsi (bound to hdc) could not initialize the cdrom
> drive.
>
> Best wishes
>
> Norbert
>

I saw something very similar in 2.4.23-pre2, couldn't swear it was exactly the 
same, but definitely very similar. The very odd thing was that it only 
occured the first time I booted the kernel (at which pointed I rebooted to 
the old one and rebuilt it, but then forgot to copy the new image into /boot 
and rebooted). The next time it booted fine and since then (20+ boots?) it 
seems to have worked fine every time. I've got ide-scsi on hdc as well and 
had applied the cpufreq patch too, wonder if thats important. Not had a 
chance to try 2.4.23-pre4 yet, I've been away. I'm using gcc version 3.3 
20030226 (prerelease) (SuSE Linux).
Regards,
Edward

