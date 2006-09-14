Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWINOhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWINOhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWINOhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:37:51 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:7941 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750862AbWINOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:37:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C/enhsgcvAOFtsSksgLJgUoW/cSBVENPpnM5AsLwGPqa2rp39/2VmchgY8ZrbSrQwYQdMWYbgJRHJ38TnLa2kuQLAOCW7BG+89EuX1FUvb4MckV6uhNncayHrn2Srtm2JPKZaNAZkWQzZV+yUEjRMEsNPCXM+FfiIFq/YBDHpHM=
Message-ID: <45096936.4040007@gmail.com>
Date: Thu, 14 Sep 2006 23:37:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] 2.6.18-rc6, SATA, resume from RAM
References: <87u03dcmfc.fsf@pereiro.luannocracy.com> <20060912132838.GQ7767@gimli>
In-Reply-To: <20060912132838.GQ7767@gimli>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz wrote:
> On Tue, Sep 12, 2006 at 08:13:43AM -0400, David Abrahams wrote:
>> Since installing a 2.6.18-rc6 kernel, my Thinkpad T60P's SATA hard
>> drive doesn't seem to spin up when resuming from a suspend-to-RAM.  Am
>> I missing something obvious, is this a kernel bug, or am I missing
>> something less-obvious ;-)?
> 
> I don't know if your T60 has the same issue like my X60s but I had to patch
> my kernel to get a proper resume
> 
> I applied forrest zhauo's set of ahci patches to 2.6.18-rc5
> 
> you find those patches here:
> http://marc.theaimsgroup.com/?l=linux-ide&m=115277002327654&w=2
> 
> maybe they find there way into the kernel sometime :-)

Those patches are currently in -mm and will make into 2.6.19-rc1 when it 
opens.

-- 
tejun
