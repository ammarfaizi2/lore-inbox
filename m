Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWD0M25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWD0M25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWD0M25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:28:57 -0400
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:12237 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S965097AbWD0M25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:28:57 -0400
From: Massimiliano Hofer <max@nucleus.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: question about procfs
Date: Thu, 27 Apr 2006 14:28:24 +0200
User-Agent: KMail/1.9.1
X-Face: K`wgvx&HhZL9|Oz+ZIU$]O&CG5N(Zr(QXdPZhk~,S*XNK9.}0u`+=SwR|^2cW.{Ei}F'0(=?utf-8?q?=0A=09q?=>|]o"}A4'HvAe=!Q_W/t9']yG%RA'[j6iX8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271428.29764.max@nucleus.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying various things with procfs, but there's one thing I can't find in 
any existing code or documentation.
If I define a hook for proc_iops->unlink in a procfs directory and do a 
remove_proc_entry() when called, I always get this message:

"de_put: deferred delete of ..."

Everything seems to work, but I get the warning.
I see 3 possibilities:
- I'm doing it the wrong way (likely);
- it's an overzealous warning that everyone should ignore;
- it's officially deemed as a Bad Thing (TM) (also likely).

Does anyone know why the warning is there?

I know procfs is not supposed to be meddled too much, but I'm just trying to 
hack. :)

-- 
Saluti,
   Massimiliano Hofer
        Nucleus
