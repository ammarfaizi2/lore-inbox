Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDCAuL>; Mon, 2 Apr 2001 20:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDCAtw>; Mon, 2 Apr 2001 20:49:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20435 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131832AbRDCAtt>;
	Mon, 2 Apr 2001 20:49:49 -0400
Message-ID: <3AC91E05.F11BFF43@mandrakesoft.com>
Date: Mon, 02 Apr 2001 20:49:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <877l13whzw.fsf@danube.cs.umbc.edu> <3AC89389.46317572@coplanar.net> <3AC91800.22D66B24@mandrakesoft.com> <3AC91B5B.1612945D@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> If you have a lot of kernels around, which Config-2.4.3 applies to kernel 2.4.3
> given 5 to choose from...the idea (same for System.map) is that it being in the
> same
> file they can't be confused.  Kinda like forks under Mac (but let's not go there
> now)

The same applies to kernel modules too.  Are you going to put all those
in the kernel image too?

If it's a file, read it from a filesystem after the kernel has booted. 
There is no need to special case this stuff.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
