Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTLZTTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTLZTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:19:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265227AbTLZTTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:19:32 -0500
Message-Id: <200312261919.hBQJJOM00527@mail.osdl.org>
Date: Fri, 26 Dec 2003 11:19:21 -0800 (PST)
From: markw@osdl.org
Subject: DBT-2 PostgreSQL on STP w/ LVM2
To: linux-kernel@vger.kernel.org, stp-devel@lists.sourceforge.net,
       linux-lvm@sistina.com, osdldbt-general@lists.sourceforge.net,
       pgsql-hackers@postgresql.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DBT-2 and PostgreSQL 7.4 is finally working with LVM2 at 100 and 200
warehouse scale factors on 8-processor system in STP with 40 drives (38
managed under LVM), but not without a few catches. I have written up
some brief instructions on how to execute the test successfully with the
Linux-2.6.0 stable release:
	http://developer.osdl.org/markw/stp_dbt2_howto.html

The instructions also cover how to get oprofile annoted assembly source
in the test results.  Feel free to ask any questions.
-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
