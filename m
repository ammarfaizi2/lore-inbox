Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTDHKAu (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 06:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDHKAu (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 06:00:50 -0400
Received: from [195.95.38.160] ([195.95.38.160]:29430 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S261292AbTDHKAt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 06:00:49 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Thomas Hood <jdthood@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.66] APM loses track of batteries
Date: Tue, 8 Apr 2003 12:12:35 +0200
User-Agent: KMail/1.5.1
References: <1049749907.1801.16.camel@thanatos>
In-Reply-To: <1049749907.1801.16.camel@thanatos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304081212.35208.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 23:11, Thomas Hood wrote:
> With two batteries inserted you see:
> > devilkin@laptop:~$ cat /proc/apm
> > 1.16ac 1.2 0x03 0x01 0xff 0x10 -1% -1 ?
>
> I think the problem is that your firmware doesn't know how
> to report battery status when two batteries are installed.
> When you momentarily remove one of the two batteries,
> the firmware is momentarily able to report the state of the
> remaining battery.
>
> My guess is that the only solution is to use ACPI.

Unfortunately, this works flawlessly under 2.4.20. With APM. So I really doubt 
this...

DK
