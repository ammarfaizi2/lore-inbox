Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUDSNqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUDSNhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:37:25 -0400
Received: from main.gmane.org ([80.91.224.249]:38113 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264225AbUDSNaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:30:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: CFQ iosched praise: good perfomance and better latency
Date: Mon, 19 Apr 2004 23:27:09 +1000
Message-ID: <87r7ukksia.fsf@enki.rimspace.net>
References: <20040419005651.GA7860@larroy.com> <40835F4E.5000308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203-217-29-45.perm.iinet.net.au
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.5 (celeriac, linux)
Cancel-Lock: sha1:VauGC1jtWRFsHuWilXr2ZWODEkA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Nick Piggin wrote:
> Pedro Larroy wrote:
>> Hi
>> I've been trying CFQ ioscheduler in my software raid5 with nice
>> results,
>> I've observed that a latency pattern still exists, just as in the
>> anticipatory ioscheduler, but those spikes are now much lower (from
>> 6ms with AS to 2ms with CFQ as seen in the bottom of
>> http://pedro.larroy.com/devel/iolat/analisys/),
>> plus apps seems to get a fair amount of io so they don't get starved.
>> Seems a good choice for io loaded boxes. Thanks Jens Axboe.
> 
> Although AS isn't at its best when behind raid devices (it should
> probably be in front of them), you could be seeing some problem
> with the raid code.

Hrm.  So, if AS isn't a good to have behind RAID devices, but is
reasonable before them, is there any easy way to configure a system like
that?

I don't see an easy way to change the IO scheduler on a per-device basis
anywhere...

        Daniel


-- 
A wonderful discovery, psychoanalysis.  
Makes quite simple people feel they're complex.
        -- S. N. Behrman

