Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280246AbRJaOkK>; Wed, 31 Oct 2001 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280249AbRJaOkB>; Wed, 31 Oct 2001 09:40:01 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:14998 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280246AbRJaOjx>;
	Wed, 31 Oct 2001 09:39:53 -0500
Date: Wed, 31 Oct 2001 14:40:27 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan <jo_ni@telia.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Still having problems with eepro100
Message-ID: <1217333392.1004539227@[10.132.113.67]>
In-Reply-To: <38130000.1004461656@shed>
In-Reply-To: <38130000.1004461656@shed>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan,

--On Tuesday, October 30, 2001 5:07 PM +0000 Alex Bligh - linux-kernel 
<linux-kernel@alex.org.uk> wrote:

> If you mean occasional lockups, which go away if you do ifdown / ifup,
> then try the patch I posted Sunday - it forces one of the bug workarounds
> on, which was dependent on eeprom by default. Also has a debug line
> which writes out what it thinks the chip ID is, which activates
> (or not) the other bug workaround. Alan put some or all of this
> patch into the latest -ac; from his docs I couldn't tell whether
> he put in the 'always use bug override' bit, and I expect not.
> if you want to do it yourself, find where rx_bug is set, and just
> set it to 1 the line afterwards, and try that.

Though this worked for me before, it appears to have stopped working
and I don't think I reverted the code (sigh). Are you by any chance
using something with apm in, or using it as a module and removing
the module? The only difference here between working and non-working
is that I've suspended and resumed the machine (/without/ power
management / apm compiled in).

> Alternatively, try the intel drivers.

I am informed by someone who really should know that this /does/ work.

--
Alex Bligh
