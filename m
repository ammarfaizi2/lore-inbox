Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131671AbQLLG7f>; Tue, 12 Dec 2000 01:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbQLLG7Y>; Tue, 12 Dec 2000 01:59:24 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:12948 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S131671AbQLLG7T>;
	Tue, 12 Dec 2000 01:59:19 -0500
Message-ID: <20001212142846.A14979@saw.sw.com.sg>
Date: Tue, 12 Dec 2000 14:28:46 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Tom Murphy <freyason@yahoo.com>
Cc: Dragan Stancevic <visitor@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre7 shutdowns and eepro100 woes
In-Reply-To: <20001211185219.28022.qmail@web2006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20001211185219.28022.qmail@web2006.mail.yahoo.com>; from "Tom Murphy" on Mon, Dec 11, 2000 at 10:52:19AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 11, 2000 at 10:52:19AM -0800, Tom Murphy wrote:
>    Also, regarding the eepro100 driver, are there any plans to fix
> support for the following chipset (given by lspci):
> 
[snip]
>   I have one of these at work and I will get the following messages:
> 
> Dec 11 10:46:13 morpheus kernel: eepro100: cmd_wait for(0xffffff80)
> +timedout with(0xffffff80)!
> Dec 11 10:46:20 morpheus last message repeated 6 times
> 
>    (using eepro100 from 2.2.18pre27.. I guess it's not 2.2.18 proper)

Last time you asked the similar question, my answer to you bounced.

This debug output was submitted by Dragan Stancevic <visitor@valinux.com>.
The current timeout values are high enough to try to increase them more.
The question I'm interested in is how command 0x80 appeared in the command
register...

To answer your question in short, yet, we hope to fix the problem sooner or
later.

Regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
