Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADXIT>; Thu, 4 Jan 2001 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbRADXII>; Thu, 4 Jan 2001 18:08:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57613 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129534AbRADXIB>;
	Thu, 4 Jan 2001 18:08:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Michael Elizabeth Chastain <mec@shout.net>
Subject: Make errors in 2.4 drivers/acpi, recursive CFLAGS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 10:07:51 +1100
Message-ID: <11067.978649671@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least one of the reported make errors on drivers/acpi is caused by a
bug in make 3.78 on alpha.  3.79 works on alpha for that user and 3.77
and 3.79 work on ix86 for me.

Anybody getting recursive CFLAG errors on drivers/acpi with make 3.78
should upgrade to 3.79 or downgrade to 3.77.  The recommended version
is 3.77.  If you still get a problem with 3.77 or 3.79, let me know.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
