Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUBWRmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUBWRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:42:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:23996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261968AbUBWRms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:42:48 -0500
Message-Id: <200402231742.i1NHgcE17332@mail.osdl.org>
Date: Mon, 23 Feb 2004 09:42:34 -0800 (PST)
From: markw@osdl.org
To: pgsql-hackers@postgresql.org
cc: linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
       osdldbt-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/markw/ia64/dbt2/

I have a summary of intial results from our DBT-2 workload with
PostgreSQL 7.4.1 on a 4-way Itanium2 system with 16GB of memory and 56
drives using LVM2 and linux-2.6.3.  There's readprofile
and oprofile data, but oprofile is seg faulting when it's trying to
generate the annotated assembly source.

I'm still trying to get a feel for how large of a database I can run
with it, but I wanted to share what I've got so far.  It looks like I
have quite a bit of unused system resources, so I probably have to tune
the database and perhaps how I'm driving the load a bit.

Let me know if there are any questions.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
