Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136759AbRAHL7N>; Mon, 8 Jan 2001 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137067AbRAHL6x>; Mon, 8 Jan 2001 06:58:53 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:32017 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S136759AbRAHL6l>;
	Mon, 8 Jan 2001 06:58:41 -0500
Date: Mon, 8 Jan 2001 17:27:07 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
Reply-To: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>, kernelnewbies@humbolt.nl.linux.org
Subject: Module
Message-ID: <Pine.SOL.3.96.1010108151925.4960A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I am facing problems in loading a module under 2.2.16. The actual
kernel is 2.2.14 and it loads in it without any trouble, but when I run my 
unmodified kernel 2.2.16(I only patched the kdb patch with it and
configured with all kernel hacking options on) and try to do a insmod, it
says that it could not find the kernel the module was compiled for. I put
the CONFIG_MODVERSIONS on(ie, included modversions.h) also included the
specific version.h file. (I declared the __NO_VERSION__ before including
module.h so that it does not  include version.h). But still it does not
work. Any idea whats going wrong?

-sourav    
--------------------------------------------------------------------------------
SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : www2.csa.iisc.ernet.in/~sourav 
ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 (COMP LAB) 
--------------------------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
