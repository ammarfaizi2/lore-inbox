Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbRETUHT>; Sun, 20 May 2001 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbRETUHJ>; Sun, 20 May 2001 16:07:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7609 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262208AbRETUHB>;
	Sun, 20 May 2001 16:07:01 -0400
Message-ID: <3B0823DF.E99BD0F8@mandrakesoft.com>
Date: Sun, 20 May 2001 16:06:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
In-Reply-To: <Pine.LNX.4.05.10105202145520.1667-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> 
> Since a while include/linux/init.h contains the line
> 
>     * Also note, that this data cannot be "const".
> 
> Why is this? Because const data will be put in a different section?

Causes a "section type conflict" build error, at least on x86.


> FWIW, many sources still use __init for data, while it should be __initdata.

*blink* wow

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
