Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSBSTNl>; Tue, 19 Feb 2002 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288981AbSBSTNb>; Tue, 19 Feb 2002 14:13:31 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:30425 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S288971AbSBSTN1>; Tue, 19 Feb 2002 14:13:27 -0500
Date: Tue, 19 Feb 2002 13:07:13 -0600
From: John Hughes <johughes@shaw.ca>
Subject: 2.5.5 NVidia driver compile fails
To: linux-kernel@vger.kernel.org
Message-id: <0GRS001V4NKSMU@l-daemon>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a whole bunch of warnings, then this:

nv.c: In function `nv_kern_open':
nv.c:1149: invalid operands to binary &
nv.c:1153: invalid operands to binary &
nv.c: In function `nv_kern_close':
nv.c:1260: invalid operands to binary &
nv.c: In function `nv_kern_mmap':
nv.c:1389: warning: passing arg 1 of `remap_page_range_Reb32c755' makes 
pointer from integer without a cast
nv.c:1389: incompatible type for argument 4 of `remap_page_range_Reb32c755'
nv.c:1389: too few arguments to function `remap_page_range_Reb32c755'
nv.c:1406: warning: passing arg 1 of `remap_page_range_Reb32c755' makes 
pointer from integer without a cast
nv.c:1406: incompatible type for argument 4 of `remap_page_range_Reb32c755'
nv.c:1406: too few arguments to function `remap_page_range_Reb32c755'
nv.c:1438: warning: passing arg 1 of `remap_page_range_Reb32c755' makes 
pointer from integer without a cast
nv.c:1438: incompatible type for argument 4 of `remap_page_range_Reb32c755'
nv.c:1438: too few arguments to function `remap_page_range_Reb32c755'
make[2]: *** [nv.o] Error 1

Has anyone got a working patch for the NVidia tree?

John Hughes
