Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVJ2TUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVJ2TUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVJ2TUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:20:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:1414 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932104AbVJ2TUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:20:03 -0400
Message-ID: <4363CB60.2000201@pobox.com>
Date: Sat, 29 Oct 2005 15:20:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org>
In-Reply-To: <20051029121454.5d27aecb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to obtain misc fixes and cleanups, and to merge
>> the ATA passthru (SMART support) feature.
> 
> 
> Are you sure this doesn't propagate Max Kellermann's "2.6.14-rc4-mm1 and
> later: second ata_piix controller is invisible" regression?
> 
> He did confirm that git-libata-all.patch caused it.

Highly doubtful.

Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and 
(tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see 
if anything breaks.

I think it's some of Alan's changes that aren't yet merged upstream, 
though I could be wrong.

	Jeff



