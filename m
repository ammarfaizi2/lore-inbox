Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWGYUGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWGYUGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGYUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:06:32 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:59659 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S964849AbWGYUGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:06:31 -0400
From: Arnaud Patard <apatard@mandriva.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Organization: Mandriva
References: <20060725034247.GA5837@kroah.com>
	<m33bcqdn5y.fsf@anduin.mandriva.com>
	<200607251123.40549.adq_dvb@lidskialf.net>
	<Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
Date: Tue, 25 Jul 2006 22:10:46 +0200
In-Reply-To: <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Tue, 25 Jul 2006 09:47:43 -0700 (PDT)")
Message-ID: <m3ac6xzbqx.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> writes:

> On Tue, 25 Jul 2006, Andrew de Quincey wrote:
>
>> On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
>>> Greg KH <gregkh@suse.de> writes:
>>>
>>> Hi,
>>>
>>>> We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
>>>
>>> Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
>>>
>>>> Andrew de Quincey:
>>>>       v4l/dvb: Fix budget-av frontend detection
>>
>>
>> In fact it is just this patch causing the problem:
> <SNIP>
>> Sorry, I had so much work going on in that area I must have diffed the wrong
>> kernel when I created this patch. :(
>
> is it reasonable to have an aotomated test figure out what config options are 
> relavent to a patch (or patchset) and test compile all the combinations to catch 
> this sort of mistake?

you'll probably need to find some heuristics which may be quite hard to
do. It would be easier imho to use some scripts like this one :
http://developer.osdl.org/~cherry/compile/ 

It's often enough to catch compile failures


Arnaud Patard

>
> David Lang

