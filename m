Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTD3VWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTD3VWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:22:03 -0400
Received: from fep02.superonline.com ([212.252.122.41]:14996 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id S261198AbTD3VWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:22:01 -0400
Message-ID: <3EB0413D.2050200@superonline.com>
Date: Thu, 01 May 2003 00:33:49 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com, kernel@mandrakesoft.com
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far, so good...

I can happily boot, halt, play some opengl games, perform my daily
routines, etc.  This should also be related to the bug recorded at
Mandrake-bugzilla: http://qa.mandrakesoft.com/show_bug.cgi?id=3198 .
I also reported this to kernel@mandrakesoft.com .

Regards;
Özkan Sezer


-------- Original Message --------
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Wed, 30 Apr 2003 21:58:42 +0300
From: O.Sezer <sezero@superonline.com>
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk,  kernel@mandrakesoft.com

For the record:

This patch posted by Adam Mercer solved my previously reported
problem about the mmio clash of CDM680 and GeForce3-Ti200 / 128MB
(see thread: "IDE siimage Problem" at:
   http://marc.theaimsgroup.com/?l=linux-kernel&m=104773593910239&w=2
   disscussed offlist with Alan).
Very preliminary testing (no modules built, no initrd, only the
vmlinuz) did not show any mmio clash and boot was fine.
Dmesg and syslog files (gzipped) are attached. I may/will report
more results upon more testing if/when necessary.

Regards,
Özkan Sezer


