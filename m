Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGYQsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGYQsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGYQsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:48:31 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46809 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932449AbWGYQsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:48:31 -0400
Date: Tue, 25 Jul 2006 09:47:43 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andrew de Quincey <adq_dvb@lidskialf.net>
cc: Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: automated test? (was Re: Linux 2.6.17.7)
In-Reply-To: <200607251123.40549.adq_dvb@lidskialf.net>
Message-ID: <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
References: <20060725034247.GA5837@kroah.com>  <m33bcqdn5y.fsf@anduin.mandriva.com>
 <200607251123.40549.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Andrew de Quincey wrote:

> On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
>> Greg KH <gregkh@suse.de> writes:
>>
>> Hi,
>>
>>> We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
>>
>> Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
>>
>>> Andrew de Quincey:
>>>       v4l/dvb: Fix budget-av frontend detection
>
>
> In fact it is just this patch causing the problem:
<SNIP>
> Sorry, I had so much work going on in that area I must have diffed the wrong
> kernel when I created this patch. :(

is it reasonable to have an aotomated test figure out what config options are 
relavent to a patch (or patchset) and test compile all the combinations to catch 
this sort of mistake?

David Lang

