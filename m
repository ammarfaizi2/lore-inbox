Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHWWjC>; Fri, 23 Aug 2002 18:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSHWWjC>; Fri, 23 Aug 2002 18:39:02 -0400
Received: from freeside.toyota.com ([63.87.74.7]:2832 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S313113AbSHWWjC>; Fri, 23 Aug 2002 18:39:02 -0400
Message-ID: <3D66BA7C.6000503@lexus.com>
Date: Fri, 23 Aug 2002 15:43:08 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [OT] sendmail kernel tuning params
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We're setting up some new sendmail boxes
which we intend to keep pretty busy, on the
order of millions of messages/mo anyway.

The systems are dual processor Dell 2450
w/ perc raid running Red Hat 7.3 -

Following the best practices from the sendmail
BOF at Linux World, we've installed sendmail
8.12.5, and have created 16 queues on reiserfs
partitions which are mounted -notail, -noatime.

Do any sendmail/kernel gurus have words of
wisdom on recommended kernel sysctl params
for such a beast? I mean they look good, but
I'd like to make sure I'm getting the best possible
sendmail performance and not missing anything.

The sendmail guy at the BOF lost his laptop or
something and didn't have the recommended
params handy -  I haven't been able to raise
him since then either.

Any pointers, or whacks with clue-by-fours are
gladly accepted.

Best Regards,

Joe


