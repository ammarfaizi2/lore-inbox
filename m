Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbUDZRyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUDZRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUDZRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:54:08 -0400
Received: from dsl081-101-153.den1.dsl.speakeasy.net ([64.81.101.153]:57520
	"EHLO mail.chen-becker.org") by vger.kernel.org with ESMTP
	id S263161AbUDZRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:54:06 -0400
Message-ID: <408D4CB4.4070901@chen-becker.org>
Date: Mon, 26 Apr 2004 11:53:56 -0600
From: Derek Chen-Becker <derek@chen-becker.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Troubleshooting PS/2 mouse in 2.6.5
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I'm upgrading my workstation from 2.4.22 to 2.6.5 and everything is 
working great except for /dev/input/mice: it doesn't appear to be 
producing anything, even if I cat it. I've checked and both dmesg and 
/proc/bus/input/devices show the mouse handler loaded and show the mouse 
as recognized. I've tried disabling ACPI because I saw it mentioned when 
I googled, but that didn't help. I've also tried loading the event 
handler module and I get nothing there either. I have another PC with 
2.6.5 working fine with the same mouse. Both are hooked up to the same 
KVM, would that have anything to do with it? Does anyone know where I 
could look to get more detail on what's happening?

Thanks,

Derek

-- 
+---------------------------------------------------------------+
| Derek Chen-Becker                                             |
| derek@chen-becker.org                                         |
| http://chen-becker.org                                        |
|                                                               |
| PGP key available on request or from public key servers       |
| ID: 21A7FB53                                                  |
| Fngrprnt: 209A 77CA A4F9 E716 E20C  6348 B657 77EC 21A7 FB53  |
+---------------------------------------------------------------+
