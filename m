Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbQLTEZL>; Tue, 19 Dec 2000 23:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131110AbQLTEYv>; Tue, 19 Dec 2000 23:24:51 -0500
Received: from linuxcare.com.au ([203.29.91.49]:32004 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130873AbQLTEYl>; Tue, 19 Dec 2000 23:24:41 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14912.11470.540247.408234@diego.linuxcare.com.au>
Date: Wed, 20 Dec 2000 14:51:42 +1100 (EST)
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday() non-monotonic on uniprocessor system with ntp turned 
         off?
In-Reply-To: <3A3E336C.B29BBA89@nortelnetworks.com>
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com>
	<3A3E336C.B29BBA89@nortelnetworks.com>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen writes:

> I am having a little bit of a problem.  I'm on a single processor G4 system
> running 2.2.17 and I do not have ntp turned on.  However, successive calls to
> gettimeofday() occasionally return results that make it look as though time was
> running backwards.  

Looking at the code in the kernel, I can't see why this would happen.
Could you send me the code for your test program so I can chase this?

Paul.

-- 
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
