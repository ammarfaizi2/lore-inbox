Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTCGD5c>; Thu, 6 Mar 2003 22:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCGD5c>; Thu, 6 Mar 2003 22:57:32 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:15495 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP
	id <S261338AbTCGD5b>; Thu, 6 Mar 2003 22:57:31 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disabling ATAPI retry?
In-Reply-To: <1046991672.17715.134.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "06 Mar 2003 23:01:12 +0000")
References: <3e67c49b.7c12.1804289383@wideopenwest.com>
	<1046991672.17715.134.camel@irongate.swansea.linux.org.uk>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Fri, 07 Mar 2003 15:08:02 +1100
Message-ID: <87k7fbq0nx.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Mar 2003, Alan Cox wrote:
> On Thu, 2003-03-06 at 20:58, kelleycook@wideopenwest.com wrote:
>> Is there a boot parameter or a runtime command that can tell
>> the linux IDE driver not to automatically retry on error.
> 
> There isn't. You can always build a kernel set not to, but even then
> it takes the drive firmware a sizeable time to retry a block. 

Hrm. Is this something that is likely to be introduced at some point?

My interest lies in the fact that I use a Linux based DVD player which
locked up for around twenty minutes the other night trying to read a
dozen bad blocks on a DVD with a single scratch...

Being able to reduce that time lag to a minimum, even if it left the
hardware delays, would be great -- even if it was only for ATAPI
devices.


The biggest slowdown was the kernel retrying each block a number of
times, then performing a full ATAPI bus reset before giving up.

       Daniel

-- 
Why could one never do a natural thing without having to
screen it behind a structure of artifice?
        -- Edith Wharton,  _House of Mirth_
