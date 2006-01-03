Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWACOH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWACOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWACOH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:07:27 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:52693 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751422AbWACOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:07:26 -0500
Date: Tue, 3 Jan 2006 05:58:23 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andi Kleen <ak@suse.de>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <200601031452.10855.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0601030556370.30559@qynat.qvtvafvgr.pbz>
References: <20050726150837.GT3160@stusta.de> <p7364p1jvkx.fsf@verdi.suse.de>
 <200601031347.19328.s0348365@sms.ed.ac.uk> <200601031452.10855.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Andi Kleen wrote:

>> Even if Adrian's not trying to make this point (he's just removing duplicate
>> drivers, and opting for the newer ones), we accepted ALSA into the kernel.
>> It's probably about time we let OSS die properly, for sanity purposes.
>
> Avoiding bloat is more important.

given that the ALSA drivers are not going to be removed, isn't it bloat to 
have two drivers for the same card?

yes, an individual compiled kernel may be slightly smaller by continueing 
to support the OSS driver, but the source (and the maintinance) are 
significantly worse by haveing two drivers instead of just one.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

