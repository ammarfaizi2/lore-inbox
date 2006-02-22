Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWBVQ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWBVQ2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBVQ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:28:15 -0500
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:5792 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751352AbWBVQ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:28:14 -0500
Message-ID: <43FC90E4.10805@torque.net>
Date: Wed, 22 Feb 2006 11:27:16 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org>
In-Reply-To: <20060222160602.GB17473@merlin.emma.line.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Wed, 22 Feb 2006, Douglas Gilbert wrote: 
>>Matthias Andree wrote:
>>>Does this work around new incompatibilities in the kernel
>>>or does this fix lsscsi bugs?
>>
>>The former. In lk 2.6.16-rc1 the
>>/sys/class/scsi_device/<hcil>/device/block symlink
>>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
>>earlier) and sg_map26 (in sg3_utils).
> 
> Heck, what was the reason for breaking userspace again?

Maybe the person responsible can answer. I'm only reacting
to a change that broke two of my utilities.

> Why would someone even consider using sysfs at all if it changes
> incompatibly?

Indeed.

Doug Gilbert
