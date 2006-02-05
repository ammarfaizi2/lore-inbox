Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWBEFIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWBEFIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 00:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWBEFIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 00:08:09 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:24846 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932622AbWBEFII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 00:08:08 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ed Sweetman <safemode@comcast.net>
Subject: Re: athlon 64 dual core tsc out of sync
Date: Sun, 5 Feb 2006 05:08:08 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com> <1139105306.2791.83.camel@mindpipe> <43E56ACA.5050108@comcast.net>
In-Reply-To: <43E56ACA.5050108@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602050508.08228.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 03:02, Ed Sweetman wrote:
[snip]
> In any case it's been generally accepted that pm timer is suggested to
> get around these errors, but i've been unable to use mine, there is no
> config option in menuconfig/gconfig etc and my .config seems to show
> that it's compiled in.   Boot args like timer=pmtmr and just pmtmr and
> having nothing have resulted in the same dmesg output , with no mention
> of using the pm-timer.   I know I used it in 2.6.14.3 and never had any
> sync issues, my setup and config hasn't changed since then except for
> the use of libata for pata.   So how can i determine what's going on
> here?   Default or not, i'd like to get the pmtmr in use if it's what
> works.

On x86 (NOT x86-64), clock=pmtmr does what you want.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
