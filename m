Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264366AbUEDNkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUEDNkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUEDNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:40:24 -0400
Received: from mspdsmtp2.mindspeed.com ([199.33.64.93]:5788 "EHLO
	mspdsmtp2.mindspeed.com") by vger.kernel.org with ESMTP
	id S264366AbUEDNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:40:23 -0400
Subject: Linux 2.6 crypto API and HW accelerators
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF4ED7CD00.900586C8-ONC1256E8A.00491716-C1256E8A.004B08FD@nice.mindspeed.com>
From: remy.gauguey@mindspeed.com
Date: Tue, 4 May 2004 15:39:35 +0200
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on SOPHIAM1/Server/Mindspeed(Release 5.0.12  |February
 13, 2003) at 05/04/2004 03:39:48 PM,
	Itemize by SMTP Server on NPBLNH1/Server/Conexant(Release 5.0.12  |February
 13, 2003) at 05/04/2004 06:39:48 AM,
	Serialize by Router on NPBLNH1/Server/Conexant(Release 5.0.12  |February 13, 2003) at
 05/04/2004 06:40:01 AM,
	Serialize complete at 05/04/2004 06:40:01 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on a ARM920T based network processor with arm-linux
kernel 2.6.5.
This device has a crypto hardware accelerator dedicated to IPsec.
In ESP mode the device can do authentication (SHA-1, MD5) as well as
encryption (AES, TDES in CBC or ECB mode) in one pass.
Unfortunately current Linux 2.6 crypto API doesn't support this kind of
hardware accelerator. Current crypto module relies on crypto algorithms
which are called for a single operation and for each block.

Then, I would like to know if other people are working on the hardware
crypto support in kernel 2.6.x.
If so, what would be the plan ? crypto api improvement or new IPsec
specific hardware support ?

Thanks for any feedback or info.

Remy Gauguey




