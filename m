Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131651AbQKRLGa>; Sat, 18 Nov 2000 06:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131671AbQKRLGU>; Sat, 18 Nov 2000 06:06:20 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:20494 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131651AbQKRLGI>;
	Sat, 18 Nov 2000 06:06:08 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Anil Kumar Prasad <anil_411@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: passing arguments to module 
In-Reply-To: Your message of "Sat, 18 Nov 2000 03:07:47 -0800."
             <20001118110747.7997.qmail@web1304.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 Nov 2000 21:36:03 +1100
Message-ID: <22529.974543763@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000 03:07:47 -0800 (PST), 
Anil Kumar Prasad <anil_411@yahoo.com> wrote:
>sorry i didn't ask the question properly. I need to
>know how does kernel modules accept run time arguments
>from user?

MODULE_PARM(variable, type) in the code.  It defines which variables
can be set on the insmod command and what type of data to accept.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
