Return-Path: <linux-kernel-owner+w=401wt.eu-S933042AbWLaGwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbWLaGwh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 01:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbWLaGwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 01:52:37 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:2664 "EHLO argo2k.argo.co.il"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933042AbWLaGwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 01:52:36 -0500
Message-ID: <45975E21.1040508@argo.co.il>
Date: Sun, 31 Dec 2006 08:52:17 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: any chance to bypass BIOS check for VT?
References: <b6a2187b0612290230g7e494670h6396e2f0a4ecea10@mail.gmail.com>	 <459629F5.2000602@argo.co.il> <b6a2187b0612301958k7d9a6d27v53c7f5592cb1a1b5@mail.gmail.com>
In-Reply-To: <b6a2187b0612301958k7d9a6d27v53c7f5592cb1a1b5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2006 06:52:29.0837 (UTC) FILETIME=[3D53ABD0:01C72CA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
>
>> A ps/2 mouse should be enabled automatically.  What makes you think it
>> is disabled?
>
> It's enabled, but I don't see the mouse. If I cat /proc/mouse, I see
> the raw data, but pointer doesn't show up in the screen.
>

Are you sure the guest is configured correctly?

Please try with -no-kvm (or with the modules unloaded).


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

