Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbTCLWVZ>; Wed, 12 Mar 2003 17:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbTCLWVZ>; Wed, 12 Mar 2003 17:21:25 -0500
Received: from freeside.toyota.com ([63.87.74.7]:6638 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S262079AbTCLWVX>; Wed, 12 Mar 2003 17:21:23 -0500
Message-ID: <3E6FB55C.1070209@tmsusa.com>
Date: Wed, 12 Mar 2003 14:31:56 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: named vs 2.5.64-mm5
References: <20030312113126.703de259.akpm@digeo.com>	<1047503813.17931.2.camel@rth.ninka.net>	<3E6FB472.20809@tmsusa.com> <20030312.142951.76164766.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>If bind errors internally because it cannot
>set SO_BSDCOMPAT, this is likely the problem.
>
>You need to hack the bind sources to remove references
>to SO_BSDCOMPAT.
>

Aha (light bulb goes on) -

OK, I'll take a look at the bind code and see...

Thanks for the clue -

Joe

