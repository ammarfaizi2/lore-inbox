Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310408AbSCPXED>; Sat, 16 Mar 2002 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310416AbSCPXDx>; Sat, 16 Mar 2002 18:03:53 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:25618 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S310408AbSCPXDl>; Sat, 16 Mar 2002 18:03:41 -0500
Subject: Re: Oops in 2.5.7-pre2: ACPI?
From: Miles Lane <miles@megapathdsl.net>
To: Alex Walker <alex@x3ja.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020316213319.Q9664@x3ja.co.uk>
In-Reply-To: <20020316213319.Q9664@x3ja.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 16 Mar 2002 15:02:42 -0800
Message-Id: <1016319763.30947.3.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-16 at 13:33, Alex Walker wrote:
> Please CC me in!
> 
> Please find attached details of an oops I get in 2.5.7-pre2 with the
> attached config.
> 
> Up to 2.5.7-pre1 ACPI worked fine with System, Processor and Button
> options enabled.
> 
> If I disable all the options, leaving just ACPI support, it still oopss.
> 
> If I disable ACPI totally, it boots fine.
> If I disable Power management, but leave ACPI and option selected, it
> also oopss.
> 
> The only change I have made to the vanilla tree is the changes is
> fs/reiserfs/journal.c that I was told about on here the other day.

I have reproduced this problem.  If a copy of my .config file
would be helpful, just let me know and I'll send it along.

	Miles

