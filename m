Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTESRqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTESRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:46:30 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:20617 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262548AbTESRq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:46:28 -0400
Message-ID: <3EC91B6D.9070308@blue-labs.org>
Date: Mon, 19 May 2003 13:59:09 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org>
In-Reply-To: <20030519124539.B8868@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The question still remains unanswered.  How do you get the sanitized 
headers?  "Use your vendor" is NOT the answer.  People need to get off 
their high horses and stop passing the buck to the ambiguous "vendor".  
Even the vendor (gentoo in this case) needs the answer on how to make 
sanitized headers.

We are nearly 70 versions into 2.5 and approaching 2.6 quickly.  There 
are numerous userland programs that are now using kernel headers because 
2.4 headers simply don't suffice anymore -- they don't support the 
hardware or interfaces of today's equipment.  It used to be "use the 
headers that you compiled the system with [glibc]" but that doesn't even 
work anymore.

We don't need the bullsh*t answer "don't use kernel headers" because 
there are oodles of packages now that require the information that is in 
kernel headers for one reason or another, some fishy, some legit.  In a 
perfect world we'd have a nice set of APIs for everybody that was always 
kept freshly up to date from all the maintainers.  If it isn't 
centralized and synchronized in the kernel headers there every package 
out there is going to be maintaining patches against the kernel source 
so their module builds correctly and this leads to patch co-existence 
nightmares.

Someone please step up to the plate and explain how to convert kernel 
headers into sanitized headers for /usr/include.

Thank you and flames > /dev/null

David

>They don't.  You can run the same userspace on a wide range of kernels.
>I'd just leave the job of selcting your headers to the distro vendor -
>if they are too stupid to get their headers sanitized I'd
>just use a different distro.
>


