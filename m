Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTK1E7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 23:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTK1E7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 23:59:11 -0500
Received: from mail.gmx.de ([213.165.64.20]:39914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261974AbTK1E7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 23:59:08 -0500
X-Authenticated: #11556596
Date: Fri, 28 Nov 2003 10:28:54 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031128045854.GA1353@home.woodlands>
Mail-Followup-To: Apurva Mehta <apurva@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.6.0-testx kernels, I have noticed that there are problems with
GNU Parted. Parted says that the disk geometries reported by the
kernel are incorrect. Here is a sample error message :

---
Error: The partition table on /dev/hdb is inconsistent.  There are
many reasons why this might be the case.  However, the most likely
reason is that Linux detected the BIOS geometry for /dev/hdb
incorrectly.  GNU Parted suspects the real geometry should be
782/128/63 (not 6256/16/63).  You should check with your BIOS first,
as this may not be correct.  You can inform Linux by adding the
parameter hdb=782,128,63 to the command line.  See the LILO or GRUB
documentation for more information.  If you think Parted's suggested
geometry is correct, you may select Ignore to continue (and fix Linux
later).  Otherwise, select Cancel (and fix Linux and/or the BIOS now).
---

Please let me know if you'll need any additional information.

I am not subscribed to this list so please cc me any replies.

Regards,

	- Apurva
