Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSLQR0H>; Tue, 17 Dec 2002 12:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSLQR0H>; Tue, 17 Dec 2002 12:26:07 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:26548
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265470AbSLQR0G>; Tue, 17 Dec 2002 12:26:06 -0500
Message-ID: <3DFF5FFE.8070305@redhat.com>
Date: Tue, 17 Dec 2002 09:33:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dada1 <dada1@cosmosbay.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com> <3DFF023E.6030401@redhat.com> <000b01c2a5bd$ebb6e870$760010ac@edumazet>
In-Reply-To: <000b01c2a5bd$ebb6e870$760010ac@edumazet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dada1 wrote:

> You could have only one routine that would need a relocation / patch at
> dynamic linking stage :

That's a horrible way to deal with this in DSOs.  THere is no writable
and executable segment and it would have to be created which means
enormous additional setup costs and higher memory requirement.  I'm not
going to use any scode modification.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

