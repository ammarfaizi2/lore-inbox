Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131584AbQLQBqI>; Sat, 16 Dec 2000 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbQLQBp5>; Sat, 16 Dec 2000 20:45:57 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:44293 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131584AbQLQBpv>; Sat, 16 Dec 2000 20:45:51 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linus's include file strategy redux
Date: 17 Dec 2000 01:15:26 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91h43e$cec$1@enterprise.cistron.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com> <91e0so$9bn$1@enterprise.cistron.net> <20001216171000.L3199@cadcamlab.org>
X-Trace: enterprise.cistron.net 977015726 12748 195.64.65.67 (17 Dec 2000 01:15:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001216171000.L3199@cadcamlab.org>,
Peter Samuelson  <peter@cadcamlab.org> wrote:
>[Miquel van Smoorenburg]
>> In fact, the 2.2.18 kernel already puts a 'build' symlink in
>> /lib/modules/`uname -r` that points to the kernel source,
>> which should be sufficient to solve this problem.. almost.
>> 
>> It doesn't tell you the specific flags used to compile the kernel,
>> such as -m486 -DCPU=686
>
>Sure it does.
>
>  make -C /lib/modules/`uname -r`/build modules SUBDIRS=$(pwd)

Excellent. Is there any way to put his in a Makefile?

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
