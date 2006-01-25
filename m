Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWAYSWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWAYSWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWAYSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:22:31 -0500
Received: from mail.gmx.net ([213.165.64.21]:17614 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750823AbWAYSWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:22:30 -0500
X-Authenticated: #428038
Message-ID: <43D7C1DF.1070606@gmx.de>
Date: Wed, 25 Jan 2006 19:22:23 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: grundig@teleline.es, Joerg Schilling <schilling@fokus.fraunhofer.de>,
       jengelh@linux01.gwdg.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
In-Reply-To: <20060125173127.GR4212@suse.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
> on potentially useful devices.

Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
complicated and non-portable. I understand that applications that can just
open every device and send SCSI INQUIRY might want to do that on Linux, too.
