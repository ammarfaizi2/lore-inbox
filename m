Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKKBvL>; Sat, 10 Nov 2001 20:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280773AbRKKBuw>; Sat, 10 Nov 2001 20:50:52 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:55825 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S280771AbRKKBup>; Sat, 10 Nov 2001 20:50:45 -0500
Date: Sun, 11 Nov 2001 01:48:02 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcrl@redhat.com
Subject: Re: [RFT] final cur of tr based current for -ac8
Message-ID: <20011111014802.A1984@compsoc.man.ac.uk>
In-Reply-To: <20011110141440.C17437@redhat.com> <20011110203348.A98674@compsoc.man.ac.uk> <20011110173331.F17437@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011110173331.F17437@redhat.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 05:33:31PM -0500, Benjamin LaHaise wrote:

> Thanks...  I seem to have blotched the SMP side of things (again) which this 
> might fix (including the symbol export from you).  Also, Michael Barabanov 
> came up with a patch using the same trick, although I haven't seen it.

You forgot -N option of diff :

Only in v2.4.13-ac8+tr.4/include/linux: per_cpu.h

Testing on my SMP box would be a bit awkward (not set up ppp/serial, so would have
to transfer patches from 2.4.5 by floppy ;) but if you need an SMP test done,
just shout.

On the UP box, the previous patch has now survived several hours under very heavy
NMI load, so I assume it's good.

thanks
john

-- 
"I know I believe in nothing but it is my nothing"
	- Manic Street Preachers
