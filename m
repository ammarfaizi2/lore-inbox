Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280723AbRKGAoq>; Tue, 6 Nov 2001 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280721AbRKGAog>; Tue, 6 Nov 2001 19:44:36 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:6059 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280723AbRKGAoY>;
	Tue, 6 Nov 2001 19:44:24 -0500
Date: Wed, 07 Nov 2001 00:44:21 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Riley Williams <rhw@MemAlpha.cx>, Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <812671195.1005093860@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX>
In-Reply-To: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 07 November, 2001 12:00 AM +0000 Riley Williams 
<rhw@MemAlpha.cx> wrote:

>  2. The kernel makes no internal reference to the /dev/rtc driver,
>     and it is left to userland tools to sync to the RTC on boot,
>     and at other times as required.

I think the kernel should set the machine time to the RTC time
as an initializer on boot. Other than that, I agree.

--
Alex Bligh
