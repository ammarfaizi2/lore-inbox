Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129582AbQKXJDm>; Fri, 24 Nov 2000 04:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129971AbQKXJDb>; Fri, 24 Nov 2000 04:03:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:50696 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129582AbQKXJDS>;
        Fri, 24 Nov 2000 04:03:18 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Pekka Savola <pekkas@netcore.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raising MAX_UNITS in net drivers oopses kernel reproducibly 
In-Reply-To: Your message of "Thu, 23 Nov 2000 23:09:18 +0200."
             <Pine.LNX.4.30.0011232253350.21863-100000@netcore.fi> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Nov 2000 19:33:03 +1100
Message-ID: <966.975054783@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000 23:09:18 +0200 (EET), 
Pekka Savola <pekkas@netcore.fi> wrote:
>EIP:    0010:[de4x5:de4x5_probe+24259/37172]
>Note! EIP shows de4x5 for some reason.  Please note that de4x5 driver

Because klogd tried to convert the oops and made a complete mess of it.
Always start klogd as "klogd -x" and run the oops through ksymoops
instead of letting the horribly broken klogd stamp on the report.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
