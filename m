Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVE0Rkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVE0Rkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVE0Rkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:40:35 -0400
Received: from fmr23.intel.com ([143.183.121.15]:47035 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261762AbVE0Rka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:40:30 -0400
Message-Id: <200505271738.j4RHcqg04138@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>
Cc: <jamagallon@able.es>, <tomlins@cam.org>, <linux-kernel@vger.kernel.org>,
       <alsa-devel@lists.sourceforge.net>
Subject: RE: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 10:38:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVisvsBMkEmiZY5T7mI3zRWYY1hlgAL7Iyg
In-Reply-To: <200505271229.01699.rjw@sisk.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote on Friday, May 27, 2005 3:29 AM
> > I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> > possible that it lies elsewhere.
> 
> Well, yes.  Apparently, it goes away if you revert the following patch:
> 
> avoiding-mmap-fragmentation-fix-2.patch


avoiding-mmap-fragmentation-fix-2.patch has a major clash using
vm_private_data where alsa is also using.  I just posted a patch,
please try that out.  Thanks.

http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2

- Ken

