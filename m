Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161344AbWASKe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161344AbWASKe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWASKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:34:27 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:9929 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161344AbWASKe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:34:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=HnYwkAcfupBO01gb4DBUbZFRu7nTnf26bCOw1vCIpHvTrafo7rWxLhIzEyzOaxHRNrRDIIlciEoKF8v4XErTQoOhfvR5j4CzFNpka0g+anLBr5TeT1YR3qjV4APM9QbdFW27GUtOuNMkYV8kOUqIuktIkcq7w9A9x9LmdeQPdcQ=
Date: Thu, 19 Jan 2006 05:34:19 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250 Documentation fix
Message-ID: <20060119103419.GA26764@roll>
References: <20060114092142.GA10844@roll> <20060114092925.GA9443@flint.arm.linux.org.uk> <20060118112121.GA10343@roll> <20060118113832.GB24960@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20060118113832.GB24960@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
From: tmhikaru@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Timothy Charles McGrath <tmHikaru@gmail.com>

This fixes the documentation error for 'SERIAL_8250' in
drivers/serial/Kconfig

This applies vs 2.6.15.1

Signed-off-by: Timothy Charles McGrath <tmHikaru@gmail.com>

---

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- linux-2.6.15.1/drivers/serial/Kconfig.orig	2006-01-08 07:24:42.000000000 -0500
+++ linux-2.6.15.1/drivers/serial/Kconfig	2006-01-19 05:02:23.000000000 -0500
@@ -23,7 +23,7 @@ config SERIAL_8250
 	  work.)
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called serial.
+	  module will be called 8250.
 	  [WARNING: Do not compile this driver as a module if you are using
 	  non-standard serial ports, since the configuration information will
 	  be lost when the driver is unloaded.  This limitation may be lifted

--NzB8fVQJ5HfG6fxh--
