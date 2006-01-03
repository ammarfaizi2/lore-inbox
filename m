Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWACJWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWACJWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWACJWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:22:53 -0500
Received: from [202.125.80.34] ([202.125.80.34]:22020 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750780AbWACJWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:22:53 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: compile time errors building the gcc-3.3.3 over FC4
Date: Tue, 3 Jan 2006 14:47:10 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B223C42@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: compile time errors building the gcc-3.3.3 over FC4
Thread-Index: AcYQRnoVcLXv5b1RQDqcoaa3zNsdvw==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel groups, 

I have special requirement of gcc-3.3.3 i.e. FC2 default gcc over the FC4.
I am getting compile time errors when trying to build the gcc-3.3.3 over the FC4 dist. 
The procedure I followed and error messages I got below:

#./configure --enable-c99
# make bootstrap
....
....
....
./read-rtl.c: warning: traditional C rejects ISO C style function definitions
./read-rtl.c: 653: error: invalid lvalue in increment
make[1]: *** [read-rtl.o] Error 1
make[1]: Leaving directory '/root/gcc-3.3.3/gcc'
make[1]: *** [all-gcc] Error 2

Also, I am able to compile the gcc-3.3.3 over RedHat 9 whose gcc is 3.2.2. 
I tried to rpm install the gcc but it rejected saying that what I installing is older than the default existing one.

Do I need to pass additional arguments to configure script an well as make? please help resolving this issue.. 
Its almost 24 hrs I am bearing this.

Best Regards,
Mukund Jampala 

