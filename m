Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUD1Wwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUD1Wwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUD1Wwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:52:55 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:45071 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261628AbUD1Www (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:52:52 -0400
Message-ID: <409036C4.7030102@techsource.com>
Date: Wed, 28 Apr 2004 18:57:08 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org> <20040427203426.GB6116@openzaurus.ucw.cz>
In-Reply-To: <20040427203426.GB6116@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:
> Hi!
> 
> 
>>>>Well, why not do the compression at the highest layer?
>>>>[...] doing it transparently and for all files.
>>>
>>>http://e2compr.sourceforge.net/
>>
>>It's been done (see the above URL), but given how cheap disk space has
>>gotten, and how the speed of CPU has gotten faster much more quickly
>>than disk access has, many/most people have not be interested in
>>trading off performance for space.  As a result, there are race
> 
> 
> Is CPU_speed / disk_throughput increasing? If so, compression
> might help once again. CPU_speed / net_throughput probably is
> increasing, so compressedNFS would probably make sense.


I've always felt that way, but every time I mention it, people tell me 
it's not worth the CPU overhead.  For many years, I have felt that there 
should be an IP socket type which was inherently compressed.

