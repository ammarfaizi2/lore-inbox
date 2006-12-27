Return-Path: <linux-kernel-owner+w=401wt.eu-S932425AbWL0Tta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWL0Tta (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWL0Tta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 14:49:30 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:2124 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932626AbWL0Tt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 14:49:29 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: idle RAID1 cpu usage
Date: Wed, 27 Dec 2006 19:49:50 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061227180900.GA10373@msgid.wurtel.net>
In-Reply-To: <20061227180900.GA10373@msgid.wurtel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271949.50723.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 18:09, Paul Slootman wrote:
[snip]
> My question is: why is CPU being used by the RAID1 threads, even for
> those devices that are otherwise unused? What are they doing?
> I even started distributed-net to check that it wasn't just idle CPU
> cycles that were being used :-)
>
> Note: it did seem that the activity was a bit more during the first
> day after booting; in fact, the mdX_raid1 threads together had used
> about one hour's worth of CPU in the first 24 hours, i.e. 4% CPU
> (according to ps and top).

Sounds like a bug to me. My box is x86_64, but it's been up for 2 days and one 
unmounted md_raid5 has used 0 minutes, 0 seconds of CPU, which is what I'd 
expect.

Maybe it's some sort of accounting problem on SPARC?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
