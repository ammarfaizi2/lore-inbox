Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVGZQBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVGZQBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGZP7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:59:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56761 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261922AbVGZP5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:57:11 -0400
Message-ID: <42E65D50.3040808@pobox.com>
Date: Tue, 26 Jul 2005 11:57:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de> <1122393073.18884.29.camel@mindpipe>
In-Reply-To: <1122393073.18884.29.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-07-26 at 17:08 +0200, Adrian Bunk wrote:
> 
>>This patch schedules obsolete OSS drivers (with ALSA drivers that 
>>support the same hardware) for removal.
> 
> 
> How many non-obsolete OSS drivers were there?

someone needs to test the remaining PCI ID(s) that are in i810_audio but 
not ALSA.


