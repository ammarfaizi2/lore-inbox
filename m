Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWA0Ox2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWA0Ox2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWA0Ox2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:53:28 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37310 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751259AbWA0Ox1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:53:27 -0500
Message-ID: <43DA33D9.5080701@pobox.com>
Date: Fri, 27 Jan 2006 09:53:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
CC: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
References: <20060120031555.7b6d65b7.akpm@osdl.org> <986ed62e0601211045p4a61a7c2v91d401af86f50d6@mail.gmail.com> <200601211636.24693.edt@aei.ca> <200601230739.45525.edt@aei.ca>
In-Reply-To: <200601230739.45525.edt@aei.ca>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ed Tomlinson wrote: > Summarizing all this. There are
	two problems here. > > 1. reserifs4 panics when it gets io errors - I
	remember this was an issue that > needed to be fixed in the R4 code
	before it moves to mainline... > > 2. Why does a drive which is fine
	with 2.6.15-rc5-mm3, return a -5 with 2.6.16-mm3 > and above? Smart
	reports no problems with the drive hardware. What has changed > in the
	libata/scsi stacks? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> Summarizing all this.  There are two problems here.
> 
> 1. reserifs4 panics when it gets io errors - I remember this was an issue that
> needed to be fixed in the R4 code before it moves to mainline...
> 
> 2. Why does a drive which is fine with 2.6.15-rc5-mm3, return a -5 with 2.6.16-mm3
> and above?  Smart reports no problems with the drive hardware.  What has changed 
> in the libata/scsi stacks?

That's a long answer.  Could you assist in narrowing down the versions 
which are affected?

It would also be useful if you could try vanilla kernels, and help us 
discover whether problems surfaces in 2.6.15, 2.6.15-git[1234], 
2.6.16-rc1, etc.

	Jeff



