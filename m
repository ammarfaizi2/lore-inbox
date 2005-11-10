Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVKJV0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVKJV0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVKJV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:26:12 -0500
Received: from kirby.webscope.com ([204.141.84.57]:16096 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932089AbVKJV0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:26:11 -0500
Message-ID: <4373BACA.7040503@m1k.net>
Date: Thu, 10 Nov 2005 16:25:30 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mchehab@brturbo.com.br
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, video4linux-list@redhat.com
Subject: Re: [Patch 17/20] V4L (963.1) hybrid v4l/dvb: remove duplicated code
References: <1131656168.6478.52.camel@localhost>
In-Reply-To: <1131656168.6478.52.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:

>From: Michael Krufky <mkrufky@m1k.net>
>
>- The following patch caused a duplicated code in cx88-dvb.c
>
>Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>
> drivers/media/video/cx88/cx88-dvb.c |    3 ---
> 1 files changed, 3 deletions(-)
>
Mauro chopped my description on this patch...... The description above 
doesnt make any sense... It SHOULD read as follows:

The following patch caused some duplicated code in cx88-dvb.c:
[PATCH] v4l: 634: implemented tuner set standby on cx88 init

The cx88-dvb.c portion of this patch was already applied
in an earlier patch, entitled:
[PATCH] v4l: fixup on cx88_dvb for Dvico HDTV5 Gold

I love quilt and all, but AFAIK, no tool is 100% perfect for catching 
oversights like this.

The non-overlapping portions of each of these patches are still needed, 
and must not be discarded, so rather than reverting old patches, please 
just apply this fixup patch to remove the duplicated code.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>


Now, maybe my description was wordy, but the one-liner doesnt tell us 
ANYTHING meaningful.

Thanks.

-- 
Michael Krufky


