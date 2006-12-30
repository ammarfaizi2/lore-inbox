Return-Path: <linux-kernel-owner+w=401wt.eu-S1754266AbWL3I5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbWL3I5j (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 03:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbWL3I5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 03:57:39 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:4428 "EHLO argo2k.argo.co.il"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754264AbWL3I5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 03:57:38 -0500
Message-ID: <459629F5.2000602@argo.co.il>
Date: Sat, 30 Dec 2006 10:57:25 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: any chance to bypass BIOS check for VT?
References: <b6a2187b0612290230g7e494670h6396e2f0a4ecea10@mail.gmail.com>
In-Reply-To: <b6a2187b0612290230g7e494670h6396e2f0a4ecea10@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2006 08:57:33.0359 (UTC) FILETIME=[8B5C83F0:01C72BF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> kvm: disabled by bios
>
> I know this has been asked before and the answer was no. Does it still
> stand or is there a way to bypass the bios? I'm using Lenovo X60s and
> there's no option to enable VT in the BIOS setup.

When it says "disabled by bios" it means what it says.  There is no 
workaround other than going to the bios and enabling it; if your bios 
doesn't support enabling VT, complain to your vendor.

>
> /proc/cpuinfo shows "VMX".
>
>
> Another question ... how to enable "mouse" in KVM?
>
>

A ps/2 mouse should be enabled automatically.  What makes you think it 
is disabled?

kvm questions are best asked on kvm-devel@lists.sourceforge.net, where 
the developers and many users hang out.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

