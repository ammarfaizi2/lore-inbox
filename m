Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAEBKW>; Thu, 4 Jan 2001 20:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131356AbRAEBKN>; Thu, 4 Jan 2001 20:10:13 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:8708 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S130687AbRAEBKG>; Thu, 4 Jan 2001 20:10:06 -0500
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
In-Reply-To: <3A54DC87.5B861B7@goingware.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: "Michael D. Crawford"'s message of "Thu, 04 Jan 2001 20:26:47 +0000"
Date: 04 Jan 2001 19:10:06 -0600
Message-ID: <m37l4akdn5.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael> APM gives its message first in the boot process, then later
Michael> ACPI does.  But ACPI says something like "APM already
Michael> present, exiting", so the doc is wrong both ways you read it,
Michael> or else ACPI doesn't succeed in the intended behavior to
Michael> override APM.

I get th eopposite behavior.  If both are compiled in only ACPI works.
(Only tested w/ 2.4.0-test kernels, though.)

Either way you need the userspace daemon running to actually do
anything.  Even my notebook's key for toggling full-screen vs
un-expanded display on the lcd does nothing unless apmd or acpid
as applicable are running....

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
