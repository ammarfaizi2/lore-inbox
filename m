Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDXSbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDXSbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWDXSbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:31:37 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:53429 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S1751102AbWDXSbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:31:37 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG at drivers/md/kcopyd.c:146
References: <20060120211116.GB4724@agk.surrey.redhat.com>
	<87odz3f5m0.fsf@blackdown.de>
	<20060420170535.GA24524@agk.surrey.redhat.com>
	<20060420124852.17dc7417.akpm@osdl.org> <871wvraro0.fsf@blackdown.de>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon
	<agk@redhat.com>, linux-kernel@vger.kernel.org
Date: Mon, 24 Apr 2006 20:31:23 +0200
In-Reply-To: <871wvraro0.fsf@blackdown.de> (Juergen Kreileder's message of
	"Fri, 21 Apr 2006 17:12:47 +0200")
Message-ID: <87k69ehll0.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder <jk@blackdown.de> writes:

> Andrew Morton <akpm@osdl.org> writes:
>
>> (restored Juergen's cc)
>
> [The cc list was correct actually, I had set a Mail-Followup-To
> header.]
>
>> Alasdair G Kergon <agk@redhat.com> wrote:
>>>
>>> On Sat, Apr 15, 2006 at 01:19:51PM +0200, Juergen Kreileder wrote:
>
> [...]
>
>>> I found several bugs in the snapshot code when I reviewed it,
>>> including (thankfully hard-to-trigger) silent data corruption.
>>>
>>> Patches went into 2.6.17-rc1.  [There's one unfinished patch
>>> outstanding for a theoretical race that I've only been able to
>>> reproduce under artificial conditions.]
>>>
>>>> kernel BUG at drivers/md/kcopyd.c:146!
>>>
>>> Probably needs this patch (12th March):
>>>
>>> dm snapshot: fix kcopyd destructor
>>>
>>
>> Thanks, I've appended a copy here.
>>
>> Juergen, can you please test this?
>
> Works fine so far but it's too early to call it fixed.
> I'll let it run over the weekend and report back.

I've seen no problems, snapshots seem to work fine with the patch.



        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
