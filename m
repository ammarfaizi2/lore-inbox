Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261832AbTCLSSl>; Wed, 12 Mar 2003 13:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCLSSl>; Wed, 12 Mar 2003 13:18:41 -0500
Received: from freeside.toyota.com ([63.87.74.7]:11724 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S261832AbTCLSSj>; Wed, 12 Mar 2003 13:18:39 -0500
Message-ID: <3E6F7C78.1040302@tmsusa.com>
Date: Wed, 12 Mar 2003 10:29:12 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: named vs 2.5.64-mm5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings -

2.5.64-mm4 and -mm5 seem more rugged than previous
kernels, but there are a couple of minor nits - one of them
is the tendency of named (which appears to work reliably
under 2.4) to go catatonic under recent 2.5.6x kernels -

More verbose kernel logging may shed some light - or is
this just a red herring? I get a tons of these in 2.5.64-mm5:

<...>
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
<...>

Anybody here running a compliant version of named?

(This is the bind 9.2.1 which ships with Red Hat 8.0)

Best Regards,

Joe


