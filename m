Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265672AbUFITRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbUFITRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFITRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:17:00 -0400
Received: from email.careercast.com ([216.39.101.233]:3784 "HELO
	email.careercast.com") by vger.kernel.org with SMTP id S265672AbUFITQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:16:58 -0400
Date: Wed, 9 Jun 2004 12:16:56 -0700
Subject: Re: slow down in 2.6 vs 2.4
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
From: Clint Byrum <cbyrum@spamaps.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <20040609033513.76754.qmail@web51807.mail.yahoo.com>
Message-Id: <92811A6A-BA49-11D8-882A-000A95730E92@spamaps.org>
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, June 8, 2004, at 08:35 PM, Phy Prabab wrote:

> Hello!
>
> Over the last two days I have been struggling with
> understanding why 2.6.x kernel is slower than
> 2.4.21/23 kernels.  I think I have a test case which
> demostrates this issue.
>

Phy, you and I have corresponded off list. I think we are experiencing 
the same thing...

>
> 2.4.21:
> 323.68user 56.07system 6:35.77elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (3138783major+3818347minor)pagefaults
> 0swaps

Is there any way to get similar numbers system wide on 2.4? This exists 
for 2.6.x, and the latest sysstat shows it with sar -B, but as the sar 
manpage states, the fault/s numbers are not available on 2.4. :(

Stats for a recent period:

Linux 2.4.23 (xxx)       06/09/2004

11:40:00 AM  pgpgin/s pgpgout/s   fault/s  majflt/s
11:50:00 AM     17.52     72.34      0.00      0.00
12:00:00 PM     20.93     65.06      0.00      0.00
Average:        19.22     68.70      0.00      0.00

Linux 2.6.6 (yyy)        06/09/04

11:40:00     pgpgin/s pgpgout/s   fault/s  majflt/s
11:50:00        70.68     81.13  13756.37      0.02
12:00:00        89.22     81.82  11598.21      0.03
Average:        79.95     81.48  12676.43      0.03


Thats from two different boxes.. see my earlier message this week for 
an explanation of the setup.

