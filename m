Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVLZTSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVLZTSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLZTSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:18:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:21453 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932111AbVLZTSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:18:46 -0500
Message-ID: <43B041FA.8000404@pobox.com>
Date: Mon, 26 Dec 2005 14:18:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaco Kroon <jaco@kroon.co.za>
CC: Lee Revell <rlrevell@joe-job.com>, jason@stdbev.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>	 <1135607906.5774.23.camel@localhost.localdomain>	 <200512261535.09307.s0348365@sms.ed.ac.uk>	 <1135619641.8293.50.camel@mindpipe>	 <0f197de4ee389204cc946086d1a04b54@stdbev.com> <1135621183.8293.64.camel@mindpipe> <43B03658.9040108@kroon.co.za>
In-Reply-To: <43B03658.9040108@kroon.co.za>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jaco Kroon wrote: > Lee Revell wrote: > >>On Mon,
	2005-12-26 at 12:09 -0600, Jason Munro wrote: >> >> >>>On 11:54:00 am
	26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote: >>> >>><snip> >>>
	>>>>>Dare I say it, KMail has also been doing the Right Thing for a
	>>>>>long time. It will only line wrap things that you insert by
	>>>>>typing; pastes are left untouched. >>>> >>>>It seems that of all
	the popular mail clients only Thunderbird has >>>>this problem. AFAICT
	it's impossible to make it DTRT with inline >>>>patches and even if it
	is the fact that most users get it wrong >>>>points to a serious
	usability/UI issue. >>>> >>>>Would a patch to add "Don't use
	Thunderbird/Mozilla Mail" to >>>>SubmittingPatches be accepted? Then we
	can point the Mozilla >>>>developers at it (they have shown zero
	interest in fixing the problem >>>>so far) and hopefully this will
	light a fire under someone. > > > I would second that patch. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco Kroon wrote:
> Lee Revell wrote:
> 
>>On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
>>
>>
>>>On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:
>>>
>>><snip>
>>>
>>>>>Dare I say it, KMail has also been doing the Right Thing for a
>>>>>long time. It will only line wrap things that you insert by
>>>>>typing; pastes are left untouched.
>>>>
>>>>It seems that of all the popular mail clients only Thunderbird has
>>>>this problem.  AFAICT it's impossible to make it DTRT with inline
>>>>patches and even if it is the fact that most users get it wrong
>>>>points to a serious usability/UI issue.
>>>>
>>>>Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
>>>>SubmittingPatches be accepted?  Then we can point the Mozilla
>>>>developers at it (they have shown zero interest in fixing the problem
>>>>so far) and hopefully this will light a fire under someone.
> 
> 
> I would second that patch.

I would NAK such a patch.

Andrew Morton described a way to do it, some method using x cut buffers, 
IIRC.

The best thing to do is use a custom script, though.  Other mailers can 
be annoying as well, with regards to the References header, for example. 
  And pine is awful, encoding plain text as base64.

	Jeff



