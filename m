Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAKIdX>; Thu, 11 Jan 2001 03:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRAKIdN>; Thu, 11 Jan 2001 03:33:13 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57865 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129737AbRAKIdA>;
	Thu, 11 Jan 2001 03:33:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mark Hindley <mh15@st-andrews.ac.uk>
cc: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 kernel paging error 
In-Reply-To: Your message of "Thu, 11 Jan 2001 08:23:33 -0000."
             <14941.28037.780373.812952@hindleyhome.st-andrews.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 19:32:50 +1100
Message-ID: <13307.979201970@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 08:23:33 +0000 (GMT), 
Mark Hindley <mh15@st-andrews.ac.uk> wrote:
>As I use the kernel module autoloader I also have a cron entry for rmmod -a
>which runs every so often to clear out the unused modules. Although
>the logs record rmmod running, they don't say what if any modules were
>removed.

If you define /var/log/ksymoops than modutils will save the symbol
table at every insert or delete of a module, all neatly timestamped.
Useful for debugging module related oops.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
