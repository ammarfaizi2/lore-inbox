Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbRAEFaY>; Fri, 5 Jan 2001 00:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131235AbRAEFaS>; Fri, 5 Jan 2001 00:30:18 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:6552 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S129450AbRAEF34>; Fri, 5 Jan 2001 00:29:56 -0500
To: kaos@ocs.com.au
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Date: Fri, 5 Jan 2001 00:22:16 -0500
Subject: 2.4.0-ac1 : 'make dep' drivers/acpi error
Message-ID: <20010105.002221.-270217.0.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0,2-8,11,14-17
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     I just downloaded 2.4.0-ac1 , and received the following error
during 'make dep':

make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux/drivers/acpi'
/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references
itself (eventually).  Stop.

I saw Keith's email about moving to make v3.77 or v3.79, if you are using
v3.78 . I confirmed that I am using make version v3.77 . So, it appears
that v3.77 doesn't work to compile drivers/acpi .
Should we look into patching Changes to make 3.79 the minimum version for
make, or 'fix' drivers/acpi (Makefile, Rules.make, etc.)? Has v3.79 been
confirmed to work? I understand v3.78 is confirmed broken.

Regards,
Frank
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
