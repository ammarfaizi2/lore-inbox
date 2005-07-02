Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVGBFXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVGBFXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 01:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVGBFXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 01:23:01 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:5091 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261799AbVGBFWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 01:22:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EPPhcdBD/ugY5kk9gEfWs+pK5Bzb1HTIt7kquUIQDzIxVYj0ZzE9yPbUXoT4t2b3ej8eAr5AcVyflMWNVRmNnIFhcpjArmevUcOPIdY+1wYT2kUwFfs1aI1Xm21ks9OwszpNDrEdsXnhgFYxUtewCHKIDN2fdsYjZRbtdkhUtmE=
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Fwd: [Bug 4817] USB storage device stalls after a few KB transfer
Date: Sat, 2 Jul 2005 09:29:14 +0400
User-Agent: KMail/1.7.2
To: Stefano Mangione <s.mangione@gmail.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507020929.14677.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----------  Forwarded Message  ----------

Subject: [Bug 4817] USB storage device stalls after a few KB transfer
Date: Saturday 02 July 2005 02:01
From: bugme-daemon@kernel-bugs.osdl.org
To: adobriyan@gmail.com

http://bugzilla.kernel.org/show_bug.cgi?id=4817

------- Additional Comments From ralf@lahn.net  2005-07-01 15:01 -------
Do you mount the usb disk with the "sync" option? 
I can confirm the low performance (few KB/s instead of 5 MB/s with Kernel 
2.6.11) when I mount with "sync". 
 
Without "sync" the performance seems to be fine although it is dangerous since 
it is a removable media. 
 
2.6.11 does not show this behavior. 
